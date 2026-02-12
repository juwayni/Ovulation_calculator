import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/main_shell.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/estimate/estimate_screen.dart';
import '../presentation/screens/analysis/analysis_screen.dart';
import '../presentation/screens/onboarding/onboarding_screen.dart';
import '../presentation/screens/log/symptom_log_screen.dart';
import '../presentation/screens/log/temperature_log_screen.dart';
import '../presentation/screens/menu/menu_screen.dart';
import '../presentation/screens/menu/edit_profile_screen.dart';
import '../presentation/screens/help/help_guide_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    GoRoute(
      path: '/onboarding',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/log-symptoms',
      builder: (context, state) => const SymptomLogScreen(),
    ),
    GoRoute(
      path: '/log-temperature',
      builder: (context, state) => const TemperatureLogScreen(),
    ),
    GoRoute(
      path: '/help',
      builder: (context, state) => const HelpGuideScreen(),
    ),
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(path: '/', builder: (context, state) => const HomeScreen()),
        GoRoute(
          path: '/estimate',
          builder: (context, state) => const EstimateScreen(),
        ),
        GoRoute(
          path: '/analysis',
          builder: (context, state) => const AnalysisScreen(),
        ),
        GoRoute(path: '/menu', builder: (context, state) => const MenuScreen()),
        GoRoute(
          path: '/edit-profile',
          builder: (context, state) => const EditProfileScreen(),
        ),
      ],
    ),
  ],
);
