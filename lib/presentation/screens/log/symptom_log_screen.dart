import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';
import '../../../data/models/symptom_model.dart';
import '../../providers/repository_providers.dart';

class SymptomLogScreen extends ConsumerStatefulWidget {
  const SymptomLogScreen({super.key});

  @override
  ConsumerState<SymptomLogScreen> createState() => _SymptomLogScreenState();
}

class _SymptomLogScreenState extends ConsumerState<SymptomLogScreen> {
  final List<String> symptoms = [
    'Cramps',
    'Headache',
    'Acne',
    'Bloating',
    'Fatigue',
    'Nausea',
    'Mood Swings',
    'Tender Breasts',
  ];
  final Set<String> selectedSymptoms = {};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Log Symptoms')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Wrap(
              spacing: 8,
              runSpacing: 8,
              children: symptoms
                  .map(
                    (s) => FilterChip(
                      label: Text(s),
                      selected: selectedSymptoms.contains(s),
                      onSelected: (selected) {
                        setState(() {
                          if (selected)
                            selectedSymptoms.add(s);
                          else
                            selectedSymptoms.remove(s);
                        });
                      },
                      selectedColor: Colors.pink.shade100,
                      checkmarkColor: Colors.pink,
                    ),
                  )
                  .toList(),
            ),
            const Spacer(),
            SizedBox(
              width: double.infinity,
              height: 50,
              child: ElevatedButton(
                onPressed: _save,
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.pink,
                  foregroundColor: Colors.white,
                ),
                child: const Text('Save Symptoms'),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _save() async {
    final repo = ref.read(symptomRepositoryProvider);
    for (final s in selectedSymptoms) {
      await repo.saveSymptom(
        SymptomModel(
          id: const Uuid().v4(),
          date: DateTime.now(),
          name: s,
          severity: 2,
        ),
      );
    }
    if (mounted) Navigator.pop(context);
  }
}
