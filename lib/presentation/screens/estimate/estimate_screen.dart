import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import '../../../core/constants/app_constants.dart';
import '../../../core/theme/theme_extension.dart';
import '../../widgets/cycle_ring_painter.dart';
import '../../providers/cycle_provider.dart';
import '../../../domain/entities/cycle_entity.dart';

class EstimateScreen extends ConsumerStatefulWidget {
  const EstimateScreen({super.key});

  @override
  ConsumerState<EstimateScreen> createState() => _EstimateScreenState();
}

class _EstimateScreenState extends ConsumerState<EstimateScreen> {
  @override
  Widget build(BuildContext context) {
    final cycleTheme = Theme.of(context).extension<CycleThemeExtension>()!;
    final cycleAsync = ref.watch(currentCycleProvider);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.chevron_left),
          onPressed: () => Navigator.maybePop(context),
        ),
        title: const Text('Estimate', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.transparent,
        elevation: 0,
        centerTitle: true,
        actions: [
          IconButton(onPressed: () {}, icon: const Icon(Icons.more_horiz)),
        ],
      ),
      body: cycleAsync.when(
        data: (cycle) => _buildContent(cycle, cycleTheme),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(CycleEntity cycle, CycleThemeExtension theme) {
    final now = DateTime.now();
    int currentDayOfCycle = now.difference(cycle.startDate).inDays + 1;
    currentDayOfCycle = currentDayOfCycle.clamp(1, cycle.cycleLength);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        children: [
          _buildCycleRingWithLabels(cycle, currentDayOfCycle, theme),
          const SizedBox(height: 40),
          _buildTemperatureCurve(theme),
        ],
      ),
    );
  }

  Widget _buildCycleRingWithLabels(CycleEntity cycle, int currentDay, CycleThemeExtension theme) {
    List<int> periodDays = List.generate(cycle.periodLength, (i) => i + 1);
    int ovulationDayIndex = cycle.ovulationDay.difference(cycle.startDate).inDays + 1;
    List<int> fertileDays = List.generate(6, (i) => ovulationDayIndex - 4 + i);
    List<int> pmsDays = List.generate(3, (i) => cycle.cycleLength - i);

    return Stack(
      alignment: Alignment.center,
      children: [
        // Ring
        SizedBox(
          width: 300,
          height: 300,
          child: CustomPaint(
            painter: CycleRingPainter(
              totalDays: cycle.cycleLength,
              currentDay: currentDay,
              periodDays: periodDays,
              fertileDays: fertileDays,
              ovulationDay: ovulationDayIndex,
              pmsDays: pmsDays,
              periodColor: theme.period,
              fertileColor: theme.fertile,
              pmsColor: theme.pms,
            ),
          ),
        ),
        // Labels
        Positioned(top: 20, left: 20, child: _buildRingLabel('PMS', theme.pms)),
        Positioned(top: 20, right: 20, child: _buildRingLabel('Period', theme.period)),
        Positioned(bottom: 50, right: 10, child: _buildRingLabel('Fertile', theme.fertile)),

        // Center Content
        Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(Icons.favorite, color: theme.period.withOpacity(0.8), size: 24),
                Transform.translate(
                  offset: const Offset(-8, 0),
                  child: Icon(Icons.favorite, color: theme.period.withOpacity(0.5), size: 24),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Estimated',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
            ),
            const Text(
              'Ovulation',
              style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRingLabel(String text, Color color) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        text,
        style: TextStyle(color: color, fontWeight: FontWeight.bold, fontSize: 12),
      ),
    );
  }

  Widget _buildTemperatureCurve(CycleThemeExtension theme) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text(
            'Temperature Curve',
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(height: 20),
        Container(
          height: 200,
          padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
          decoration: BoxDecoration(
            color: theme.period.withOpacity(0.1),
            borderRadius: BorderRadius.circular(24),
          ),
          child: LineChart(
            LineChartData(
              gridData: FlGridData(
                show: true,
                drawVerticalLine: false,
                horizontalInterval: 1,
                getDrawingHorizontalLine: (value) => FlLine(
                  color: Colors.grey.withOpacity(0.2),
                  strokeWidth: 1,
                ),
              ),
              titlesData: FlTitlesData(
                show: true,
                rightTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                topTitles: const AxisTitles(sideTitles: SideTitles(showTitles: false)),
                leftTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) => Text('${value.toInt()}°F', style: const TextStyle(fontSize: 10, color: Colors.grey)),
                    reservedSize: 35,
                  ),
                ),
                bottomTitles: AxisTitles(
                  sideTitles: SideTitles(
                    showTitles: true,
                    interval: 1,
                    getTitlesWidget: (value, meta) {
                      if (value < 3 || value > 9) return const SizedBox();
                      return Text('${value.toInt()}', style: const TextStyle(fontSize: 10, color: Colors.grey));
                    },
                  ),
                ),
              ),
              borderData: FlBorderData(show: false),
              minX: 2.5,
              maxX: 9.5,
              minY: 94.5,
              maxY: 99.5,
              lineBarsData: [
                LineChartBarData(
                  spots: const [
                    FlSpot(3, 96.0),
                    FlSpot(4, 96.5),
                    FlSpot(5, 95.8),
                    FlSpot(6, 96.8),
                    FlSpot(7, 98.2),
                    FlSpot(8, 97.2),
                    FlSpot(9, 95.5),
                  ],
                  isCurved: true,
                  color: theme.period,
                  barWidth: 2,
                  isStrokeCapRound: true,
                  dotData: FlDotData(
                    show: true,
                    getDotPainter: (spot, percent, barData, index) {
                      if (spot.x == 5) {
                        return FlDotCirclePainter(
                          radius: 6,
                          color: theme.period,
                          strokeWidth: 0,
                        );
                      }
                      return FlDotCirclePainter(radius: 0, color: Colors.transparent);
                    },
                  ),
                  belowBarData: BarAreaData(
                    show: true,
                    gradient: LinearGradient(
                      colors: [theme.period.withOpacity(0.3), theme.period.withOpacity(0.0)],
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
