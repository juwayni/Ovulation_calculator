import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../presentation/screens/main_shell.dart';
import '../presentation/screens/home/home_screen.dart';
import '../presentation/screens/estimate/estimate_screen.dart';
import '../presentation/screens/analysis/analysis_screen.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigatorKey = GlobalKey<NavigatorState>();

final appRouter = GoRouter(
  initialLocation: '/',
  navigatorKey: _rootNavigatorKey,
  routes: [
    ShellRoute(
      navigatorKey: _shellNavigatorKey,
      builder: (context, state, child) {
        return MainShell(child: child);
      },
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const HomeScreen(),
        ),
        GoRoute(
          path: '/estimate',
          builder: (context, state) => const EstimateScreen(),
        ),
        GoRoute(
          path: '/analysis',
          builder: (context, state) => const AnalysisScreen(),
        ),
      ],
    ),
  ],
);
