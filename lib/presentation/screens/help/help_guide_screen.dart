import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class HelpGuideScreen extends StatelessWidget {
  const HelpGuideScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Guide'), centerTitle: true),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildSection(
            'Understanding Your Cycle',
            'A typical menstrual cycle lasts between 21 and 35 days. It is divided into several phases: the Menstrual phase, Follicular phase, Ovulation, and Luteal phase.',
            Icons.calendar_month,
            Colors.pink,
          ),
          const SizedBox(height: 24),
          _buildSection(
            'What is Ovulation?',
            'Ovulation is when an egg is released from the ovary. This usually happens about 14 days before your next period starts. This is your most fertile time.',
            Icons.favorite,
            Colors.red,
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Tracking BBT',
            'Basal Body Temperature (BBT) is your body temperature at rest. Tracking it daily can show a slight rise (about 0.3°C to 0.5°C) after ovulation, helping confirm your fertile window.',
            Icons.thermostat,
            Colors.orange,
          ),
          const SizedBox(height: 24),
          _buildSection(
            'Why Log Symptoms?',
            'Logging symptoms like cramps, mood changes, or energy levels helps the app provide better insights into your unique cycle patterns.',
            Icons.notes,
            Colors.blue,
          ),
          const SizedBox(height: 48),
          ElevatedButton(
            onPressed: () => context.go('/'),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.pink,
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(vertical: 16),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            child: const Text(
              'Got it, let\'s go!',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          const SizedBox(height: 24),
        ],
      ),
    );
  }

  Widget _buildSection(
    String title,
    String description,
    IconData icon,
    Color color,
  ) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            borderRadius: BorderRadius.circular(12),
          ),
          child: Icon(icon, color: color),
        ),
        const SizedBox(width: 16),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                description,
                style: const TextStyle(color: Colors.black87, height: 1.4),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
