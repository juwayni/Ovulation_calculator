import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/theme_extension.dart';
import '../../widgets/circular_stat_widget.dart';
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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Analysis', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
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
      margin: const EdgeInsets.all(AppConstants.paddingMedium),
      height: 45,
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(25),
      ),
      child: TabBar(
        controller: _tabController,
        indicator: BoxDecoration(
          borderRadius: BorderRadius.circular(25),
          gradient: LinearGradient(
            colors: [Theme.of(context).colorScheme.primary, const Color(0xFFFF8C94)],
          ),
        ),
        labelColor: Colors.white,
        unselectedLabelColor: Colors.grey,
        indicatorSize: TabBarIndicatorSize.tab,
        dividerColor: Colors.transparent,
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

    final dateRange = '${DateFormat('MMM d').format(current.startDate)} - ${DateFormat('MMM d').format(current.startDate.add(Duration(days: current.cycleLength)))}';

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Center(
            child: Text(
              '$dateRange, ${current.cycleLength} days (predicted)',
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 24),
          _buildStatGrid(current, theme),
          const SizedBox(height: 32),
          const Text('Cycle Comparison', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 16),
          _buildLegend(),
          const SizedBox(height: 16),
          _buildBarChart(current, last, theme),
        ],
      ),
    );
  }

  Widget _buildStatGrid(CycleEntity cycle, CycleThemeExtension theme) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 0.85,
      children: [
        _buildStatCard('Current', 'Period', cycle.periodLength.toDouble(), cycle.cycleLength.toDouble(), theme.period),
        _buildStatCard('Current', 'Follicular Phase', 14, cycle.cycleLength.toDouble(), theme.follicular),
        _buildStatCard('Current', 'Fertile Window', 7, cycle.cycleLength.toDouble(), theme.fertile),
        _buildStatCard('Current', 'Luteal Phase', 14, cycle.cycleLength.toDouble(), theme.luteal),
      ],
    );
  }

  Widget _buildStatCard(String date, String label, double value, double max, Color color) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        children: [
          CircularStatWidget(
            value: value,
            maxValue: max,
            label: '${value.toInt()}',
            subLabel: '',
            color: color,
          ),
          const SizedBox(height: 8),
          Text(date, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 12)),
          Text(label, style: const TextStyle(color: Colors.grey, fontSize: 11), textAlign: TextAlign.center),
        ],
      ),
    );
  }

  Widget _buildLegend() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        _buildLegendItem('Current', Theme.of(context).colorScheme.primary),
        const SizedBox(width: 16),
        _buildLegendItem('Last', Theme.of(context).colorScheme.primary.withOpacity(0.3)),
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
    return SizedBox(
      height: 200,
      child: BarChart(
        BarChartData(
          alignment: BarChartAlignment.spaceAround,
          maxY: 35,
          barTouchData: BarTouchData(enabled: false),
          titlesData: FlTitlesData(
            show: true,
            bottomTitles: AxisTitles(
              sideTitles: SideTitles(
                showTitles: true,
                getTitlesWidget: (value, meta) {
                  const titles = ['Cycle', 'Period', 'Fertile', 'Follic.', 'Luteal'];
                  if (value.toInt() >= titles.length) return const SizedBox();
                  return Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Text(titles[value.toInt()], style: const TextStyle(fontSize: 10, color: Colors.grey)),
                  );
                },
              ),
            ),
            leftTitles: const AxisTitles(sideTitles: SideTitles(showTitles: true, interval: 8, reservedSize: 28)),
            topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
            rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
          ),
          gridData: const FlGridData(show: false),
          borderData: FlBorderData(show: false),
          barGroups: [
            _buildBarGroup(0, current.cycleLength.toDouble(), last?.cycleLength.toDouble() ?? 28, theme.period),
            _buildBarGroup(1, current.periodLength.toDouble(), last?.periodLength.toDouble() ?? 5, theme.follicular),
            _buildBarGroup(2, 7, 7, theme.fertile),
            _buildBarGroup(3, 14, 14, theme.pms),
            _buildBarGroup(4, 14, 14, theme.luteal),
          ],
        ),
      ),
    );
  }

  BarChartGroupData _buildBarGroup(int x, double val1, double val2, Color color) {
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(toY: val1, color: color, width: 8, borderRadius: BorderRadius.circular(4)),
        BarChartRodData(toY: val2, color: color.withOpacity(0.3), width: 8, borderRadius: BorderRadius.circular(4)),
      ],
    );
  }
}
