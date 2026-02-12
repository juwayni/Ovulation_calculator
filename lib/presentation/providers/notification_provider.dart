import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:ovulation_calculator/core/utils/notification_service.dart';
import 'package:ovulation_calculator/presentation/providers/cycle_provider.dart';

final notificationSchedulerProvider = Provider<void>((ref) {
  final cycleAsync = ref.watch(currentCycleProvider);

  cycleAsync.whenData((cycle) {
    final nextPeriod = cycle.startDate.add(Duration(days: cycle.cycleLength));
    NotificationService().scheduleNotifications(
      nextPeriod: nextPeriod,
      ovulationDay: cycle.ovulationDay,
    );
  });
});
