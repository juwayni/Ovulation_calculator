import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:intl/intl.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/date_selector.dart';
import '../../providers/cycle_provider.dart';
import '../../providers/period_provider.dart';
import '../../../data/models/period_model.dart';
import '../../../domain/entities/cycle_entity.dart';
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
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: AppConstants.paddingMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 16),
              _buildWeather(),
              const SizedBox(height: 8),
              _buildGreeting(),
              const SizedBox(height: 20),
              _buildSearchBar(),
              const SizedBox(height: 20),
              DateSelector(
                selectedDate: selectedDate,
                onDateSelected: (date) => setState(() => selectedDate = date),
              ),
              const SizedBox(height: 40),
              cycleAsync.when(
                data: (cycle) => _buildCurrentStatus(cycle),
                loading: () => const Center(child: CircularProgressIndicator()),
                error: (e, _) => Text('Error: $e'),
              ),
              const SizedBox(height: 40),
              _buildSectionHeader('Daily Insight'),
              const SizedBox(height: 12),
              _buildInsightCards(),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTopBar() {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            width: 32,
            height: 32,
            decoration: BoxDecoration(
              color: Colors.grey.shade300,
              shape: BoxShape.circle,
            ),
            child: const Center(child: Text('32x32', style: TextStyle(fontSize: 6))),
          ),
          Stack(
            children: [
              const Icon(Icons.notifications, size: 28),
              Positioned(
                right: 0,
                top: 0,
                child: Container(
                  padding: const EdgeInsets.all(2),
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                  constraints: const BoxConstraints(minWidth: 14, minHeight: 14),
                  child: const Text('2', style: TextStyle(color: Colors.white, fontSize: 8), textAlign: TextAlign.center),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildWeather() {
    return Row(
      children: [
        Icon(Icons.wb_sunny, color: Colors.orange.shade400, size: 20),
        const SizedBox(width: 8),
        Text(
          '29° C Sunny',
          style: TextStyle(color: Colors.grey.shade700, fontWeight: FontWeight.w500),
        ),
      ],
    );
  }

  Widget _buildGreeting() {
    // Ideally this comes from a user profile provider
    const String userName = 'Brooklyn Vaughn';
    return Text(
      'Hi, $userName',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
            fontWeight: FontWeight.bold,
            fontSize: 28,
            letterSpacing: -0.5,
          ),
    );
  }

  Widget _buildSearchBar() {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(30),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: const TextField(
        decoration: InputDecoration(
          icon: Icon(Icons.search, color: Colors.grey),
          hintText: 'What are you looking for?',
          hintStyle: TextStyle(color: Colors.grey, fontWeight: FontWeight.w300),
          border: InputBorder.none,
          suffixIcon: Icon(Icons.mic, color: Colors.grey),
        ),
      ),
    );
  }

  Widget _buildCurrentStatus(CycleEntity cycle) {
    int dayOfCycle = selectedDate.difference(cycle.startDate).inDays + 1;
    bool isPeriod = dayOfCycle > 0 && dayOfCycle <= cycle.periodLength;

    return Center(
      child: Column(
        children: [
          Text(
            isPeriod ? 'Period:' : 'Cycle:',
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w500),
          ),
          const SizedBox(height: 8),
          Text(
            'Day $dayOfCycle',
            style: const TextStyle(fontSize: 48, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          OutlinedButton(
            onPressed: () => _addMockPeriod(),
            style: OutlinedButton.styleFrom(
              side: const BorderSide(color: Colors.pink, width: 1.5),
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
            ),
            child: const Text(
              'Edit Period Date',
              style: TextStyle(color: Colors.pink, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _addMockPeriod() {
    final period = PeriodModel(
      id: const Uuid().v4(),
      startDate: DateTime.now().subtract(const Duration(days: 4)),
      endDate: DateTime.now().add(const Duration(days: 1)),
    );
    ref.read(periodActionProvider.notifier).addPeriod(period);
    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Mock period added (Started 4 days ago)!')));
  }

  Widget _buildSectionHeader(String title) {
    return Text(
      title,
      style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
    );
  }

  Widget _buildInsightCards() {
    return Container(
      height: 160,
      margin: const EdgeInsets.only(top: 10),
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          _buildInsightCard(
            'Log Your\nSymptoms',
            Icons.add,
            Colors.pink,
            Colors.white,
            true,
          ),
          _buildInsightCard(
            'Symptoms to\nExpect',
            Icons.favorite,
            Colors.pink,
            const Color(0xFFFDE1E3),
            false,
          ),
          _buildInsightCard(
            'Your\nDay',
            Icons.refresh,
            Colors.pink,
            const Color(0xFFFFF1F2),
            false,
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(String title, IconData icon, Color iconColor, Color bgColor, bool outlinedIcon) {
    return Container(
      width: 140,
      margin: const EdgeInsets.only(right: 16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: bgColor,
        borderRadius: BorderRadius.circular(24),
        boxShadow: bgColor == Colors.white ? [
          BoxShadow(
            color: Colors.black.withOpacity(0.02),
            blurRadius: 10,
            offset: const Offset(0, 4),
          )
        ] : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration: BoxDecoration(
              color: outlinedIcon ? Colors.pink.shade50 : Colors.white,
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: iconColor, size: 24),
          ),
          Text(
            title,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 14,
              height: 1.2,
            ),
          ),
        ],
      ),
    );
  }
}
