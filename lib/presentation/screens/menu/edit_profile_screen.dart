import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/user_provider.dart';

class EditProfileScreen extends ConsumerStatefulWidget {
  const EditProfileScreen({super.key});

  @override
  ConsumerState<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends ConsumerState<EditProfileScreen> {
  final _formKey = GlobalKey<FormState>();
  late TextEditingController _nameController;
  late int _age;
  late int _cycleLength;
  late int _periodLength;

  @override
  void initState() {
    super.initState();
    final user = ref.read(userProvider).value;
    _nameController = TextEditingController(text: user?.name ?? '');
    _age = user?.age ?? 25;
    _cycleLength = user?.cycleLength ?? 28;
    _periodLength = user?.periodLength ?? 5;
  }

  @override
  void dispose() {
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Edit Profile'), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Name',
                  border: OutlineInputBorder(),
                ),
                validator: (val) => val == null || val.isEmpty
                    ? 'Please enter your name'
                    : null,
              ),
              const SizedBox(height: 24),
              const Text('Age', style: TextStyle(fontWeight: FontWeight.bold)),
              Slider(
                value: _age.toDouble(),
                min: 13,
                max: 100,
                divisions: 87,
                label: '$_age',
                onChanged: (val) => setState(() => _age = val.toInt()),
              ),
              const SizedBox(height: 24),
              const Text(
                'Typical Cycle Length (days)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Slider(
                value: _cycleLength.toDouble(),
                min: 21,
                max: 45,
                divisions: 24,
                label: '$_cycleLength',
                onChanged: (val) => setState(() => _cycleLength = val.toInt()),
              ),
              const SizedBox(height: 24),
              const Text(
                'Typical Period Length (days)',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              Slider(
                value: _periodLength.toDouble(),
                min: 2,
                max: 14,
                divisions: 12,
                label: '$_periodLength',
                onChanged: (val) => setState(() => _periodLength = val.toInt()),
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
                    'Save Changes',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _save() async {
    if (_formKey.currentState!.validate()) {
      final user = ref.read(userProvider).value;
      if (user != null) {
        final updatedUser = user.copyWith(
          name: _nameController.text,
          age: _age,
          cycleLength: _cycleLength,
          periodLength: _periodLength,
        );
        await ref.read(userActionProvider.notifier).updateUser(updatedUser);
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text('Profile updated!')));
          Navigator.pop(context);
        }
      }
    }
  }
}
