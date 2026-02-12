import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/user_model.dart';
import '../../../data/models/period_model.dart';
import '../../providers/user_provider.dart';
import '../../providers/period_provider.dart';

class OnboardingScreen extends ConsumerStatefulWidget {
  const OnboardingScreen({super.key});

  @override
  ConsumerState<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends ConsumerState<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final TextEditingController _nameController = TextEditingController();
  int _age = 25;
  int _cycleLength = 28;
  int _periodLength = 5;
  DateTime _lastPeriodStart = DateTime.now().subtract(const Duration(days: 14));

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: LinearProgressIndicator(
                value: (_currentPage + 1) / 4,
                backgroundColor: Colors.pink.shade50,
                color: Colors.pink,
                borderRadius: BorderRadius.circular(10),
              ),
            ),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (page) => setState(() => _currentPage = page),
                children: [
                  _buildNamePage(),
                  _buildAgePage(),
                  _buildCyclePage(),
                  _buildLastPeriodPage(),
                ],
              ),
            ),
            _buildFooter(),
          ],
        ),
      ),
    );
  }

  Widget _buildNamePage() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'What\'s your name?',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 32),
          TextField(
            controller: _nameController,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 24),
            decoration: const InputDecoration(
              hintText: 'Enter your name',
              border: UnderlineInputBorder(),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAgePage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'How old are you?',
          style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        SizedBox(
          height: 200,
          child: ListWheelScrollView.useDelegate(
            itemExtent: 50,
            perspective: 0.005,
            diameterRatio: 1.2,
            onSelectedItemChanged: (index) => setState(() => _age = 13 + index),
            childDelegate: ListWheelChildBuilderDelegate(
              builder: (context, index) => Center(
                child: Text(
                  '${13 + index}',
                  style: const TextStyle(fontSize: 24),
                ),
              ),
              childCount: 87,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildCyclePage() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text(
            'Cycle Details',
            style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 48),
          _buildCounter(
            'Average Cycle Length',
            _cycleLength,
            (val) => setState(() => _cycleLength = val),
          ),
          const SizedBox(height: 32),
          _buildCounter(
            'Average Period Length',
            _periodLength,
            (val) => setState(() => _periodLength = val),
          ),
        ],
      ),
    );
  }

  Widget _buildCounter(String label, int value, Function(int) onChanged) {
    return Column(
      children: [
        Text(label, style: const TextStyle(fontSize: 18, color: Colors.grey)),
        const SizedBox(height: 16),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            IconButton(
              onPressed: () => onChanged(value - 1),
              icon: const Icon(Icons.remove_circle_outline),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Text(
                '$value days',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            IconButton(
              onPressed: () => onChanged(value + 1),
              icon: const Icon(Icons.add_circle_outline),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildLastPeriodPage() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text(
          'When was your last period?',
          style: TextStyle(fontSize: 26, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 32),
        CalendarDatePicker(
          initialDate: _lastPeriodStart,
          firstDate: DateTime.now().subtract(const Duration(days: 90)),
          lastDate: DateTime.now(),
          onDateChanged: (date) => setState(() => _lastPeriodStart = date),
        ),
      ],
    );
  }

  Widget _buildFooter() {
    return Padding(
      padding: const EdgeInsets.all(32.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          if (_currentPage > 0)
            TextButton(
              onPressed: () => _pageController.previousPage(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
              ),
              child: const Text(
                'Back',
                style: TextStyle(color: Colors.grey, fontSize: 18),
              ),
            )
          else
            const SizedBox(width: 60),
          ElevatedButton(
            onPressed: _nextPage,
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 48, vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: Text(
              _currentPage == 3 ? 'Finish' : 'Next',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }

  void _nextPage() async {
    if (_currentPage < 3) {
      _pageController.nextPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    } else {
      // Save data
      final user = UserModel(
        id: const Uuid().v4(),
        name: _nameController.text.isEmpty ? 'Friend' : _nameController.text,
        age: _age,
        cycleLength: _cycleLength,
        periodLength: _periodLength,
        onboardingCompleted: true,
      );

      await ref.read(userActionProvider.notifier).updateUser(user);

      // Save initial period
      final period = PeriodModel(
        id: const Uuid().v4(),
        startDate: _lastPeriodStart,
        endDate: _lastPeriodStart.add(Duration(days: _periodLength - 1)),
      );
      await ref.read(periodActionProvider.notifier).addPeriod(period);

      if (mounted) {
        context.go('/help');
      }
    }
  }
}
