import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/theme_extension.dart';
import '../../providers/analysis_provider.dart';
import '../../../domain/entities/cycle_entity.dart';

class AnalysisScreen extends ConsumerStatefulWidget {
  const AnalysisScreen({super.key});

  @override
  ConsumerState<AnalysisScreen> createState() => _AnalysisScreenState();
}

class _AnalysisScreenState extends ConsumerState<AnalysisScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Analysis', style: TextStyle(fontWeight: FontWeight.bold)),
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
                  const Center(child: Text('Period Analysis')),
                  const Center(child: Text('Fertile Analysis')),
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
      margin: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium, vertical: 8),
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

  Widget _buildCycleAnalysis(Map<String, dynamic> analysis, CycleThemeExtension theme) {
    final CycleEntity? current = analysis['currentCycle'];
    final CycleEntity? last = analysis['lastCycle'];

    if (current == null) {
      return const Center(child: Text('No data recorded yet.'));
    }

    final startDateStr = DateFormat('MMM d').format(current.startDate);
    final endDateStr = DateFormat('MMM d').format(current.startDate.add(Duration(days: current.cycleLength)));
    final dateRange = '$startDateStr - $endDateStr';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: RichText(
              text: TextSpan(
                style: const TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.bold),
                children: [
                  TextSpan(text: '$dateRange, ${current.cycleLength} days '),
                  const TextSpan(
                    text: '(predicted)',
                    style: TextStyle(color: Colors.grey, fontWeight: FontWeight.normal),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          _buildStatGrid(current, theme),
          const SizedBox(height: 32),
          const Text('Cycle', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
          const SizedBox(height: 16),
          _buildLegend(),
          const SizedBox(height: 16),
          _buildBarChart(current, last, theme),
          const SizedBox(height: 32),
        ],
      ),
    );
  }

  Widget _buildStatGrid(CycleEntity cycle, CycleThemeExtension theme) {
    // Calculating phases based on entity
    final periodDays = cycle.periodLength;
    final follicularDays = cycle.ovulationDay.difference(cycle.startDate).inDays - periodDays;
    final fertileDays = cycle.fertileWindowEnd.difference(cycle.fertileWindowStart).inDays + 1;
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
        _buildStatCard('Current Cycle', 'Follicular Phase', follicularDays, theme.follicular),
        _buildStatCard('Current Cycle', 'Fertile Window', fertileDays, theme.fertile),
        _buildStatCard('Current Cycle', 'Luteal Phase', lutealDays, theme.luteal),
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
                    TextSpan(text: '$days', style: const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 16)),
                    const TextSpan(text: 'days', style: TextStyle(color: Colors.grey, fontSize: 10)),
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
        Container(width: 10, height: 10, decoration: BoxDecoration(color: color, shape: BoxShape.circle)),
        const SizedBox(width: 4),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }

  Widget _buildBarChart(CycleEntity current, CycleEntity? last, CycleThemeExtension theme) {
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
                  if (rodIndex != 0 || groupIndex >= diffs.length || diffs[groupIndex].isEmpty) return null;
                  return BarTooltipItem(
                    diffs[groupIndex],
                    const TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: 12),
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
                  const titles = ['Cycle\nLength', 'Period', 'Fertile\nWindow', 'Follicula\nr Phase', 'Luteal\nPhase'];
                  if (value.toInt() >= titles.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(
                      titles[value.toInt()],
                      textAlign: TextAlign.center,
                      style: const TextStyle(fontSize: 9, color: Colors.grey, fontWeight: FontWeight.bold),
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
                    getTitlesWidget: (value, meta) => Text('${value.toInt()}', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                ),
            ),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBarGroup(0, current.cycleLength.toDouble(), last?.cycleLength.toDouble() ?? 28, theme.period),
            _buildBarGroup(1, current.periodLength.toDouble(), last?.periodLength.toDouble() ?? 5, theme.period),
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

  BarChartGroupData _buildBarGroup(int x, double val1, double val2, Color color) {
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
}
