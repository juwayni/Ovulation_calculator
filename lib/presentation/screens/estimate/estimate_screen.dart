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
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: const Text('Estimate', style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
      ),
      body: cycleAsync.when(
        data: (cycle) => _buildContent(cycle, cycleTheme),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text('Error: $e')),
      ),
    );
  }

  Widget _buildContent(CycleEntity cycle, CycleThemeExtension theme) {
    // Calculate current day relative to cycle start (simplified)
    final now = DateTime.now();
    int currentDayOfCycle = now.difference(cycle.startDate.subtract(Duration(days: cycle.cycleLength))).inDays + 1;
    currentDayOfCycle = currentDayOfCycle.clamp(1, cycle.cycleLength);

    return SingleChildScrollView(
      padding: const EdgeInsets.all(AppConstants.paddingMedium),
      child: Column(
        children: [
          _buildCycleCircle(cycle, currentDayOfCycle, theme),
          const SizedBox(height: 30),
          _buildPhaseDetails(cycle, theme),
          const SizedBox(height: 30),
          _buildTemperatureChart(theme),
        ],
      ),
    );
  }

  Widget _buildCycleCircle(CycleEntity cycle, int currentDay, CycleThemeExtension theme) {
    // Define period days, fertile days, etc based on cycle entity
    List<int> periodDays = List.generate(cycle.periodLength, (i) => i + 1);

    // Calculate fertile days indices
    int ovulationDayIndex = cycle.ovulationDay.difference(cycle.startDate.subtract(Duration(days: cycle.cycleLength))).inDays + 1;
    List<int> fertileDays = List.generate(7, (i) => ovulationDayIndex - 5 + i);

    return Center(
      child: TweenAnimationBuilder<double>(
        tween: Tween(begin: 0, end: currentDay.toDouble()),
        duration: const Duration(milliseconds: 1500),
        curve: Curves.easeOutCubic,
        builder: (context, value, child) {
          return Stack(
            alignment: Alignment.center,
            children: [
              SizedBox(
                width: 280,
                height: 280,
                child: CustomPaint(
                  painter: CycleRingPainter(
                    totalDays: cycle.cycleLength,
                    currentDay: value.toInt(),
                    periodDays: periodDays,
                    fertileDays: fertileDays,
                    ovulationDay: ovulationDayIndex,
                    pmsDays: [cycle.cycleLength, cycle.cycleLength - 1, cycle.cycleLength - 2],
                    periodColor: theme.period,
                    fertileColor: theme.fertile,
                    pmsColor: theme.pms,
                  ),
                ),
              ),
              child!,
            ],
          );
        },
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Day $currentDay',
              style: const TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold,
              ),
            ),
            Text(
              currentDay == ovulationDayIndex ? 'Ovulation Day' : 'Follicular Phase',
              style: const TextStyle(
                color: Colors.grey,
                fontSize: 16,
              ),
            ),
            const SizedBox(height: 8),
            if (fertileDays.contains(currentDay))
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
                decoration: BoxDecoration(
                  color: theme.fertile.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'High Chance',
                  style: TextStyle(
                    color: theme.ovulation,
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }

  Widget _buildPhaseDetails(CycleEntity cycle, CycleThemeExtension theme) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: [
        _buildPhaseItem('Period', '${cycle.periodLength} days', theme.period),
        _buildPhaseItem('Fertile', '7 days', theme.fertile),
        _buildPhaseItem('PMS', '3 days', theme.pms),
      ],
    );
  }

  Widget _buildPhaseItem(String label, String value, Color color) {
    return Column(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(height: 4),
        Text(label, style: const TextStyle(fontWeight: FontWeight.bold)),
        Text(value, style: const TextStyle(color: Colors.grey, fontSize: 12)),
      ],
    );
  }

  Widget _buildTemperatureChart(CycleThemeExtension theme) {
    return Container(
      height: 250,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.grey.shade50,
        borderRadius: BorderRadius.circular(24),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            'Body Temperature',
            style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 20),
          Expanded(
            child: LineChart(
              LineChartData(
                gridData: const FlGridData(show: false),
                titlesData: const FlTitlesData(show: false),
                borderData: FlBorderData(show: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: const [
                      FlSpot(0, 36.5),
                      FlSpot(1, 36.6),
                      FlSpot(2, 36.4),
                      FlSpot(3, 36.5),
                      FlSpot(4, 36.7),
                      FlSpot(5, 37.1),
                      FlSpot(6, 37.0),
                    ],
                    isCurved: true,
                    color: theme.temperatureLine,
                    barWidth: 4,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: true),
                    belowBarData: BarAreaData(
                      show: true,
                      color: theme.temperatureArea,
                    ),
                  ),
                ],
                lineTouchData: LineTouchData(
                  touchTooltipData: LineTouchTooltipData(
                    getTooltipColor: (touchedSpot) => Colors.white,
                    getTooltipItems: (touchedSpots) {
                      return touchedSpots.map((spot) {
                        return LineTooltipItem(
                          '${spot.y}°C',
                          const TextStyle(color: Colors.black, fontWeight: FontWeight.bold),
                        );
                      }).toList();
                    },
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
