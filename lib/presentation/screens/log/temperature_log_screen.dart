import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/temperature_model.dart';
import '../../providers/repository_providers.dart';

class TemperatureLogScreen extends ConsumerStatefulWidget {
  const TemperatureLogScreen({super.key});

  @override
  ConsumerState<TemperatureLogScreen> createState() =>
      _TemperatureLogScreenState();
}

class _TemperatureLogScreenState extends ConsumerState<TemperatureLogScreen> {
  double temperature = 36.6;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log BBT')),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.thermostat, size: 80, color: Colors.pink),
            const SizedBox(height: 24),
            const Text(
              'Basal Body Temperature',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            const Text(
              'Measure your temperature first thing in the morning, before getting out of bed, to track ovulation accurately.',
              textAlign: TextAlign.center,
              style: TextStyle(color: Colors.grey),
            ),
            const SizedBox(height: 48),
            Text(
              '${temperature.toStringAsFixed(1)}°C',
              style: const TextStyle(
                fontSize: 64,
                fontWeight: FontWeight.bold,
                color: Colors.pink,
              ),
            ),
            Slider(
              value: temperature,
              min: 35.0,
              max: 38.0,
              divisions: 30,
              onChanged: (val) => setState(() => temperature = val),
              activeColor: Colors.pink,
            ),
            const SizedBox(height: 48),
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(28),
                  ),
                ),
                child: const Text(
                  'Save BBT Reading',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() async {
    final repo = ref.read(temperatureRepositoryProvider);
    await repo.saveTemperature(
      TemperatureModel(
        id: const Uuid().v4(),
        date: DateTime.now(),
        value: temperature,
      ),
    );
    if (mounted) Navigator.pop(context);
  }
}
