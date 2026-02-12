import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import '../../providers/user_provider.dart';
import '../../providers/repository_providers.dart';

class MenuScreen extends ConsumerWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    final user = userAsync.value;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Menu',
          style: TextStyle(fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          _buildProfileHeader(user),
          const SizedBox(height: 32),
          _buildMenuSection(context, 'Account', [
            _buildMenuItem(
              Icons.person_outline,
              'Edit Profile',
              () => context.push('/edit-profile'),
            ),
            _buildMenuItem(Icons.notifications_none, 'Notifications', () {}),
          ]),
          const SizedBox(height: 24),
          _buildMenuSection(context, 'App Settings', [
            _buildMenuItem(Icons.language, 'Language', () {}),
            _buildMenuItem(Icons.lock_outline, 'Privacy Policy', () {}),
            _buildMenuItem(
              Icons.help_outline,
              'Help & Guide',
              () => context.push('/help'),
            ),
          ]),
          const SizedBox(height: 32),
          ElevatedButton(
            onPressed: () => _resetData(context, ref),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red.shade50,
              foregroundColor: Colors.red,
              elevation: 0,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            child: const Text('Reset All Data'),
          ),
          const SizedBox(height: 16),
          const Center(
            child: Text(
              'Ovula Version 1.0.0',
              style: TextStyle(color: Colors.grey, fontSize: 12),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileHeader(dynamic user) {
    return Row(
      children: [
        Container(
          width: 60,
          height: 60,
          decoration: const BoxDecoration(
            color: Colors.pink,
            shape: BoxShape.circle,
          ),
          child: const Center(
            child: Icon(Icons.person, color: Colors.white, size: 30),
          ),
        ),
        const SizedBox(width: 16),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              user?.name ?? 'Friend',
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'Age: ${user?.age ?? "--"}',
              style: const TextStyle(color: Colors.grey),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildMenuSection(
    BuildContext context,
    String title,
    List<Widget> items,
  ) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.bold,
            color: Colors.grey,
          ),
        ),
        const SizedBox(height: 8),
        ...items,
      ],
    );
  }

  Widget _buildMenuItem(IconData icon, String title, VoidCallback onTap) {
    return ListTile(
      leading: Icon(icon, color: Colors.pink),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right, size: 20),
      contentPadding: EdgeInsets.zero,
      onTap: onTap,
    );
  }

  void _resetData(BuildContext context, WidgetRef ref) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reset All Data?'),
        content: const Text(
          'This will permanently delete all your profile information and historical data. This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reset', style: TextStyle(color: Colors.red)),
          ),
        ],
      ),
    );

    if (confirmed == true) {
      final repository = ref.read(userRepositoryProvider);
      await repository.resetAllData();

      // Invalidate all related providers
      ref.invalidate(userProvider);
      // We might want to invalidate others but since we go to onboarding it should be fine

      if (context.mounted) {
        context.go('/onboarding');
      }
    }
  }
}
