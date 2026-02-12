import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovulation_calculator/core/theme/app_theme.dart';
import 'package:ovulation_calculator/router/app_router.dart';
import 'package:ovulation_calculator/core/utils/hive_helper.dart';
import 'package:ovulation_calculator/core/utils/notification_service.dart';
import 'package:ovulation_calculator/presentation/providers/user_provider.dart';
import 'package:ovulation_calculator/presentation/providers/notification_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await HiveHelper.init();
  await NotificationService().init();

  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final userAsync = ref.watch(userProvider);
    // Initialize notification scheduling
    ref.watch(notificationSchedulerProvider);

    return userAsync.when(
      data: (user) {
        return MaterialApp.router(
          title: 'Ovula',
          theme: AppTheme.lightTheme,
          darkTheme: AppTheme.darkTheme,
          routerConfig: appRouter,
          debugShowCheckedModeBanner: false,
        );
      },
      loading: () => const MaterialApp(
        home: Scaffold(body: Center(child: CircularProgressIndicator())),
      ),
      error: (e, s) => MaterialApp(
        home: Scaffold(body: Center(child: Text('Error: $e'))),
      ),
    );
  }
}
