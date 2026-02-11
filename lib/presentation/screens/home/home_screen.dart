import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/app_card.dart';
import '../../widgets/date_selector.dart';
import '../../providers/cycle_provider.dart';
import '../../providers/period_provider.dart';
import '../../../data/models/period_model.dart';
import 'package:uuid/uuid.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _showDisclaimer();
    });
  }

  void _showDisclaimer() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => Container(
        padding: const EdgeInsets.all(24),
        decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(width: 40, height: 4, decoration: BoxDecoration(color: Colors.grey.shade300, borderRadius: BorderRadius.circular(2))),
            const SizedBox(height: 24),
            const Icon(Icons.info_outline, color: Colors.blue, size: 48),
            const SizedBox(height: 16),
            const Text('Medical Disclaimer', style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
            const SizedBox(height: 16),
            const Text(
              'This app provides estimates and is not a medical diagnostic tool.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 32),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
                style: ElevatedButton.styleFrom(
                  backgroundColor: Theme.of(context).colorScheme.primary,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                ),
                child: const Text('I Understand'),
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final cycleAsync = ref.watch(currentCycleProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildHeader(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              DateSelector(
                selectedDate: selectedDate,
                onDateSelected: (date) => setState(() => selectedDate = date),
              ),
              const SizedBox(height: 20),
              cycleAsync.when(
                data: (cycle) => _buildCurrentStatus(cycle),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),
              const SizedBox(height: 20),
              _buildSectionHeader('Daily Insight'),
              const SizedBox(height: 12),
              _buildInsightCards(),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Hi, Jessica',
              style: Theme.of(context).textTheme.displaySmall?.copyWith(
                    fontWeight: FontWeight.bold,
                    fontSize: 24,
                  ),
            ),
            const Text('How are you feeling today?'),
          ],
        ),
        Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
            color: Colors.blue.shade50,
            borderRadius: BorderRadius.circular(12),
          ),
          child: Row(
            children: [
              Icon(Icons.wb_sunny, color: Colors.orange.shade400, size: 20),
              const SizedBox(width: 4),
              const Text('24°C', style: TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey.shade100,
        borderRadius: BorderRadius.circular(12),
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: 'Search for symptoms, tips...',
          border: InputBorder.none,
        ),
      ),
    );
  }

  Widget _buildCurrentStatus(dynamic cycle) {
    // Check if selected date is in period
    bool isPeriodDay = selectedDate.isAfter(cycle.startDate.subtract(Duration(days: cycle.cycleLength))) &&
                       selectedDate.isBefore(cycle.startDate.subtract(Duration(days: cycle.cycleLength - cycle.periodLength)));

    String status = isPeriodDay ? 'Period Day' : 'Next Period in';
    String value = isPeriodDay ? '3' : '${cycle.startDate.difference(selectedDate).inDays} days';

    return AppCard(
      color: Theme.of(context).colorScheme.primary.withOpacity(0.05),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  '$status $value',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).colorScheme.primary,
                  ),
                ),
                Text(cycle.cycleLength > 25 ? 'Your cycle is regular.' : 'Cycle slightly irregular.'),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: () => _addMockPeriod(),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Theme.of(context).colorScheme.primary,
                    foregroundColor: Colors.white,
                    elevation: 0,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                  ),
                  child: const Text('Edit Period'),
                ),
              ],
            ),
          ),
          const Icon(Icons.water_drop, size: 80, color: Colors.pink),
        ],
      ),
    );
  }

  void _addMockPeriod() {
    final period = PeriodModel(
      id: const Uuid().v4(),
      startDate: DateTime.now().subtract(const Duration(days: 28)),
      endDate: DateTime.now().subtract(const Duration(days: 23)),
    );
    ref.read(periodActionProvider.notifier).addPeriod(period);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mock period added!')));
  }

  Widget _buildSectionHeader(String title) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        TextButton(onPressed: () {}, child: const Text('See All')),
      ],
    );
  }

  Widget _buildInsightCards() {
    return SizedBox(
      height: 160,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildInsightCard(
            'Hydration Tip',
            'Drink at least 8 glasses of water today.',
            Icons.water_drop,
            Colors.blue.shade100,
          ),
          _buildInsightCard(
            'Exercise',
            'Light yoga can help with cramps.',
            Icons.self_improvement,
            Colors.green.shade100,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, String desc, IconData icon, Color color) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0, end: 1),
      duration: const Duration(milliseconds: 800),
      builder: (context, value, child) {
        return Opacity(
          opacity: value,
          child: Transform.scale(
            scale: 0.8 + (0.2 * value),
            child: child,
          ),
        );
      },
      child: Container(
        width: 200,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, size: 30),
            const SizedBox(height: 12),
            Text(title, style: const TextStyle(fontWeight: FontWeight.bold)),
            const SizedBox(height: 4),
            Text(desc, style: const TextStyle(fontSize: 12)),
          ],
        ),
      ),
    );
  }
}
