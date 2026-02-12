import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/theme_extension.dart';
import '../../providers/analysis_provider.dart';
import '../../providers/log_provider.dart';
import '../../../domain/entities/cycle_entity.dart';

class AnalysisScreen extends ConsumerStatefulWidget {
  const AnalysisScreen({super.key});

  @override
  ConsumerState<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends ConsumerState<AnalysisScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 3, vsync: this);
  }

  @override
  Widget build(BuildContext context) {
    final cycleTheme = Theme.of(context).extension<CycleThemeExtension>()!;
    final analysisAsync = ref.watch(cycleAnalysisProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text(
          'Analysis',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      body: analysisAsync.when(
        data: (analysis) => Column(
          children: [
            _buildTabSwitcher(),
            Expanded(
              child: TabBarView(
                controller: _tabController,
                children: [
                  _buildCycleAnalysis(analysis, cycleTheme),
                  _buildPeriodAnalysis(analysis, cycleTheme),
                  _buildFertileAnalysis(analysis, cycleTheme),
                ],
              ),
            ),
          ],
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildTabSwitcher() {
    return Container(
      margin: const EdgeInsets.symmetric(
        horizontal: AppConstants.paddingMedium,
        vertical: 8,
      ),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: const LinearGradient(
            colors: [Color(0xFFFF6B81), Color(0xFFFF8C94)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
        labelStyle: const TextStyle(fontWeight: FontWeight.bold),
        tabs: const [
          Tab(text: 'Cycle'),
          Tab(text: 'Period'),
          Tab(text: 'Fertile'),
        ],
      ),
    );
  }

  Widget _buildCycleAnalysis(
    Map<String, dynamic> analysis,
    CycleThemeExtension theme,
  ) {
    final CycleEntity? current = analysis['currentCycle'];
    final CycleEntity? last = analysis['lastCycle'];

    if (current == null) {
      return _buildEmptyState(
        'No cycle data available',
        'Log your first period to see detailed analysis.',
      );
    }

    final startDateStr = DateFormat('MMM d').format(current.startDate);
    final endDateStr = DateFormat(
      'MMM d',
    ).format(current.startDate.add(Duration(days: current.cycleLength)));
    final dateRange = '$startDateStr - $endDateStr';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(
                  color: Colors.black,
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
                children: [
                  TextSpan(text: '$dateRange, ${current.cycleLength} days '),
                  const TextSpan(
                    text: '(predicted)',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.normal,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildStatGrid(current, theme),
          const SizedBox(height: 32),
          const Text(
            'Cycle',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          _buildLegend(),
          const SizedBox(height: 16),
          _buildBarChart(current, last, theme),
          const SizedBox(height: 32),
          const Text(
            'Basal Body Temperature',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24),
          ),
          const SizedBox(height: 16),
          _buildBBTChart(theme),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStatGrid(CycleEntity cycle, CycleThemeExtension theme) {
    // Calculating phases based on entity
    final periodDays = cycle.periodLength;
    final follicularDays =
        cycle.ovulationDay.difference(cycle.startDate).inDays - periodDays;
    final fertileDays =
        cycle.fertileWindowEnd.difference(cycle.fertileWindowStart).inDays + 1;
    final lutealDays = cycle.cycleLength - (periodDays + follicularDays);

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 16,
      crossAxisSpacing: 16,
      childAspectRatio: 0.9,
      children: [
        _buildStatCard('Current Cycle', 'Period', periodDays, theme.period),
        _buildStatCard(
          'Current Cycle',
          'Follicular Phase',
          follicularDays,
          theme.follicular,
        ),
        _buildStatCard(
          'Current Cycle',
          'Fertile Window',
          fertileDays,
          theme.fertile,
        ),
        _buildStatCard(
          'Current Cycle',
          'Luteal Phase',
          lutealDays,
          theme.luteal,
        ),
      ],
    );
  }

  Widget _buildStatCard(String dateRange, String label, int days, Color color) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: Colors.grey.shade100),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 60,
                height: 60,
                child: CircularProgressIndicator(
                  value: days / 28,
                  strokeWidth: 4,
                  backgroundColor: Colors.grey.shade100,
                  valueColor: AlwaysStoppedAnimation<Color>(color),
                ),
              ),
              RichText(
                text: TextSpan(
                  children: [
                    TextSpan(
                      text: '$days',
                      style: const TextStyle(
                        color: Colors.black,
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                    const TextSpan(
                      text: 'days',
                      style: TextStyle(color: Colors.grey, fontSize: 10),
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 16),
          Text(
            dateRange,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12),
            textAlign: TextAlign.center,
          ),
          Text(
            label,
            style: const TextStyle(color: Colors.grey, fontSize: 11),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildLegendItem('Current', const Color(0xFFFF6B81)),
        const SizedBox(width: 16),
        _buildLegendItem('Last', const Color(0xFFFF6B81).withOpacity(0.3)),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildBarChart(
    CycleEntity current,
    CycleEntity? last,
    CycleThemeExtension theme,
  ) {
    final List<String> diffs = [];
    if (last != null) {
      diffs.add(_formatDiff(current.cycleLength - last.cycleLength));
      diffs.add(_formatDiff(current.periodLength - last.periodLength));
      // For others we can use default or calculated
      diffs.addAll(['+0', '+0', '+0']);
    } else {
      diffs.addAll(['', '', '', '', '']);
    }

    return SizedBox(
      height: 250,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 35,
          barTouchData: BarTouchData(
            enabled: true,
            touchTooltipData: BarTouchTooltipData(
              getTooltipColor: (group) => Colors.transparent,
              tooltipPadding: EdgeInsets.zero,
              tooltipMargin: 0,
              getTooltipItem: (group, groupIndex, rod, rodIndex) {
                if (rodIndex != 0 ||
                    groupIndex >= diffs.length ||
                    diffs[groupIndex].isEmpty)
                  return null;
                return BarTooltipItem(
                  diffs[groupIndex],
                  const TextStyle(
                    color: Colors.black,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                );
              },
            ),
          ),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const titles = [
                    'Cycle\nLength',
                    'Period',
                    'Fertile\nWindow',
                    'Follicula\nr Phase',
                    'Luteal\nPhase',
                  ];
                  if (value.toInt() >= titles.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      titles[value.toInt()],
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 9,
                        color: Colors.grey,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  );
                },
                reservedSize: 45,
              ),
            ),
            leftTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                interval: 8,
                reservedSize: 28,
                getTitlesWidget: (value, meta) => Text(
                  '${value.toInt()}',
                  style: const TextStyle(fontSize: 10, color: Colors.grey),
                ),
              ),
            ),
            topTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
            rightTitles: const AxisTitles(
              sideTitles: SideTitles(showTitles: false),
            ),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBarGroup(
              0,
              current.cycleLength.toDouble(),
              last?.cycleLength.toDouble() ?? 28,
              theme.period,
            ),
            _buildBarGroup(
              1,
              current.periodLength.toDouble(),
              last?.periodLength.toDouble() ?? 5,
              theme.period,
            ),
            _buildBarGroup(2, 7, 7, theme.fertile),
            _buildBarGroup(3, 14, 14, theme.follicular),
            _buildBarGroup(4, 14, 14, theme.luteal),
          ],
        ),
      ),
    );
  }

  String _formatDiff(int diff) {
    if (diff > 0) return '+$diff';
    if (diff < 0) return '$diff';
    return '0';
  }

  BarChartGroupData _buildBarGroup(
    int x,
    double val1,
    double val2,
    Color color,
  ) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: val1,
          color: color,
          width: 12,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
        BarChartRodData(
          toY: val2,
          color: color.withOpacity(0.2),
          width: 12,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(6)),
        ),
      ],
      showingTooltipIndicators: [0],
    );
  }

  Widget _buildPeriodAnalysis(
    Map<String, dynamic> analysis,
    CycleThemeExtension theme,
  ) {
    final List<CycleEntity> history = analysis['history'] ?? [];
    final Map<String, dynamic> stats = analysis['stats'] ?? {};

    if (history.isEmpty) {
      return _buildEmptyState(
        'No period history',
        'Track multiple periods to see your trends over time.',
      );
    }

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatHeader(
            'Average Period',
            '${stats['avgPeriodLength']?.toStringAsFixed(1) ?? "--"} days',
          ),
          const SizedBox(height: 24),
          const Text(
            'Period History',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: BarChart(
              BarChartData(
                alignment: BarChartAlignment.spaceAround,
                maxY: 10,
                titlesData: FlTitlesData(
                  show: true,
                  bottomTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      getTitlesWidget: (value, meta) {
                        int idx = value.toInt();
                        if (idx >= history.length) return const SizedBox();
                        return Text(
                          DateFormat('MMM').format(history[idx].startDate),
                          style: const TextStyle(fontSize: 10),
                        );
                      },
                    ),
                  ),
                  leftTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: true, reservedSize: 28),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                ),
                gridData: const FlGridData(show: false),
                borderData: FlBorderData(show: false),
                barGroups: history
                    .asMap()
                    .entries
                    .map(
                      (e) => BarChartGroupData(
                        x: e.key,
                        barRods: [
                          BarChartRodData(
                            toY: e.value.periodLength.toDouble(),
                            color: theme.period,
                            width: 16,
                          ),
                        ],
                      ),
                    )
                    .toList(),
              ),
            ),
          ),
          const SizedBox(height: 32),
          _buildTrendList(history),
        ],
      ),
    );
  }

  Widget _buildFertileAnalysis(
    Map<String, dynamic> analysis,
    CycleThemeExtension theme,
  ) {
    final Map<String, dynamic> stats = analysis['stats'] ?? {};
    final double regularity = stats['regularity'] ?? 0.0;

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildStatHeader(
            'Prediction Confidence',
            '${(regularity * 100).toInt()}%',
          ),
          const SizedBox(height: 24),
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: theme.fertile.withOpacity(0.05),
              borderRadius: BorderRadius.circular(24),
              border: Border.all(color: theme.fertile.withOpacity(0.1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Icon(Icons.info_outline, color: theme.fertile),
                    const SizedBox(width: 12),
                    const Text(
                      'About Your Prediction',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                Text(
                  regularity > 0.8
                      ? 'Your cycles are very regular, making predictions highly accurate. Ovulation usually occurs 14 days before your next period.'
                      : 'Your cycles show some variation. Using a thermometer to track Basal Body Temperature (BBT) can help improve ovulation accuracy.',
                  style: const TextStyle(color: Colors.black87, fontSize: 14),
                ),
              ],
            ),
          ),
          const SizedBox(height: 32),
          const Text(
            'Upcoming Fertile Windows',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          ),
          const SizedBox(height: 16),
          _buildUpcomingFertileList(analysis['currentCycle']),
        ],
      ),
    );
  }

  Widget _buildStatHeader(String label, String value) {
    return Center(
      child: Column(
        children: [
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 32),
          ),
        ],
      ),
    );
  }

  Widget _buildTrendList(List<CycleEntity> history) {
    return Column(
      children: history
          .map(
            (c) => ListTile(
              title: Text(DateFormat('MMMM yyyy').format(c.startDate)),
              trailing: Text(
                '${c.periodLength} days',
                style: const TextStyle(fontWeight: FontWeight.bold),
              ),
              subtitle: Text('Cycle length: ${c.cycleLength} days'),
            ),
          )
          .toList(),
    );
  }

  Widget _buildBBTChart(CycleThemeExtension theme) {
    return Consumer(
      builder: (context, ref, child) {
        final tempsAsync = ref.watch(temperaturesProvider);
        return tempsAsync.when(
          data: (temps) {
            if (temps.isEmpty) {
              return Container(
                height: 100,
                decoration: BoxDecoration(
                  color: Colors.grey.shade50,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Text(
                    'Log BBT readings to see your trend',
                    style: TextStyle(color: Colors.grey),
                  ),
                ),
              );
            }
            // Sort by date
            final sortedTemps = List.from(temps)
              ..sort((a, b) => a.date.compareTo(b.date));
            final recentTemps = sortedTemps.length > 7
                ? sortedTemps.sublist(sortedTemps.length - 7)
                : sortedTemps;

            return SizedBox(
              height: 200,
              child: LineChart(
                LineChartData(
                  gridData: const FlGridData(show: false),
                  titlesData: FlTitlesData(
                    show: true,
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (value, meta) {
                          int idx = value.toInt();
                          if (idx < 0 || idx >= recentTemps.length)
                            return const SizedBox();
                          return Text(
                            DateFormat('d/M').format(recentTemps[idx].date),
                            style: const TextStyle(fontSize: 10),
                          );
                        },
                      ),
                    ),
                    leftTitles: const AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        reservedSize: 32,
                      ),
                    ),
                    topTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                    rightTitles: const AxisTitles(
                      sideTitles: SideTitles(showTitles: false),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                  lineBarsData: [
                    LineChartBarData(
                      spots: recentTemps
                          .asMap()
                          .entries
                          .map((e) => FlSpot(e.key.toDouble(), e.value.value))
                          .toList(),
                      isCurved: true,
                      color: Colors.pink,
                      barWidth: 3,
                      dotData: const FlDotData(show: true),
                      belowBarData: BarAreaData(
                        show: true,
                        color: Colors.pink.withOpacity(0.1),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          loading: () => const SizedBox(
            height: 200,
            child: Center(child: CircularProgressIndicator()),
          ),
          error: (e, _) => Text('Error: $e'),
        );
      },
    );
  }

  Widget _buildEmptyState(String title, String message) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.bar_chart,
              size: 80,
              color: Colors.pink.withOpacity(0.2),
            ),
            const SizedBox(height: 24),
            Text(
              title,
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(
              message,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.go('/'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.pink,
                foregroundColor: Colors.white,
              ),
              child: const Text('Go to Home to Log'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildUpcomingFertileList(CycleEntity? current) {
    if (current == null) return const SizedBox();
    return Card(
      elevation: 0,
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
        side: BorderSide(color: Colors.grey.shade100),
      ),
      child: ListTile(
        leading: const CircleAvatar(
          backgroundColor: Color(0xFFE3F2FD),
          child: Icon(Icons.calendar_today, color: Colors.blue, size: 20),
        ),
        title: const Text('Next Ovulation'),
        subtitle: Text(DateFormat('EEEE, MMM d').format(current.ovulationDay)),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
