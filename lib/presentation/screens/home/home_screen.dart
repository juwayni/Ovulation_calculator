import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../core/constants/app_constants.dart';
import '../../widgets/date_selector.dart';
import '../../providers/cycle_provider.dart';
import '../../providers/period_provider.dart';
import '../../providers/user_provider.dart';
import '../../../data/models/period_model.dart';
import '../../../domain/entities/cycle_entity.dart';
import '../../widgets/medical_disclaimer_modal.dart';

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
      _checkOnboardingAndDisclaimer();
    });
  }

  void _checkOnboardingAndDisclaimer() async {
    final userAsync = ref.read(userProvider);
    final user = userAsync.value;

    if (user == null || !user.onboardingCompleted) {
      context.go('/onboarding');
      return;
    }

    if (!user.medicalDisclaimerAccepted) {
      _showDisclaimer();
    }
  }

  void _showDisclaimer() {
    MedicalDisclaimerModal.show(
      context,
      onAccept: () async {
        final user = ref.read(userProvider).value;
        if (user != null) {
          await ref
              .read(userActionProvider.notifier)
              .updateUser(user.copyWith(medicalDisclaimerAccepted: true));
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final cycleAsync = ref.watch(currentCycleProvider);
    final userAsync = ref.watch(userProvider);
    final userName = userAsync.value?.name ?? 'Friend';

    return Scaffold(
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(
            horizontal: AppConstants.paddingMedium,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildTopBar(),
              const SizedBox(height: 24),
              _buildGreeting(userName),
              const SizedBox(height: 32),
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
            child: const Center(
              child: Icon(Icons.person, size: 20, color: Colors.white),
            ),
          ),
          Stack(
            children: [
              const Icon(Icons.notifications_none_outlined, size: 28),
              Positioned(
                right: 2,
                top: 2,
                child: Container(
                  width: 10,
                  height: 10,
                  decoration: const BoxDecoration(
                    color: Colors.pink,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildGreeting(String name) {
    return Text(
      'Hi, $name',
      style: Theme.of(context).textTheme.displaySmall?.copyWith(
        fontWeight: FontWeight.bold,
        fontSize: 28,
        letterSpacing: -0.5,
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
          ElevatedButton(
            onPressed: () => _logNewPeriod(cycle),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              shape: const StadiumBorder(),
              padding: const EdgeInsets.symmetric(horizontal: 32, vertical: 16),
              elevation: 0,
            ),
            child: const Text(
              'Log New Period',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
          ),
          const SizedBox(height: 12),
          TextButton(
            onPressed: () => _editPeriodDate(cycle),
            child: const Text(
              'Edit Period Date',
              style: TextStyle(color: Colors.pink, fontWeight: FontWeight.w600),
            ),
          ),
        ],
      ),
    );
  }

  void _logNewPeriod(CycleEntity cycle) async {
    final date = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime.now().subtract(const Duration(days: 30)),
      lastDate: DateTime.now(),
    );
    if (date != null) {
      final period = PeriodModel(
        id: const Uuid().v4(),
        startDate: date,
        endDate: date.add(Duration(days: cycle.periodLength - 1)),
      );
      await ref.read(periodActionProvider.notifier).addPeriod(period);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('New period logged!')));
      }
    }
  }

  void _editPeriodDate(CycleEntity cycle) async {
    final date = await showDatePicker(
      context: context,
      initialDate: cycle.startDate,
      firstDate: DateTime.now().subtract(const Duration(days: 60)),
      lastDate: DateTime.now().add(const Duration(days: 30)),
    );
    if (date != null) {
      final period = PeriodModel(
        id: const Uuid().v4(),
        startDate: date,
        endDate: date.add(Duration(days: cycle.periodLength - 1)),
      );
      await ref.read(periodActionProvider.notifier).addPeriod(period);
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(const SnackBar(content: Text('Period updated!')));
      }
    }
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
            onTap: () => context.push('/log-symptoms'),
          ),
          _buildInsightCard(
            'Symptoms to\nExpect',
            Icons.favorite,
            Colors.pink,
            const Color(0xFFFDE1E3),
            false,
          ),
          _buildInsightCard(
            'Log Your\nBBT',
            Icons.thermostat,
            Colors.pink,
            const Color(0xFFFFF1F2),
            false,
            onTap: () => context.push('/log-temperature'),
          ),
        ],
      ),
    );
  }

  Widget _buildInsightCard(
    String title,
    IconData icon,
    Color iconColor,
    Color bgColor,
    bool outlinedIcon, {
    VoidCallback? onTap,
  }) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 140,
        margin: const EdgeInsets.only(right: 16),
        padding: const EdgeInsets.all(16),
        decoration: BoxDecoration(
          color: bgColor,
          borderRadius: BorderRadius.circular(24),
          boxShadow: bgColor == Colors.white
              ? [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.02),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ]
              : null,
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
      ),
    );
  }
}
