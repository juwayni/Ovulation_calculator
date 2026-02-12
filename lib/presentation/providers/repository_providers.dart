import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/repositories/hive_period_repository.dart';
import '../../data/repositories/hive_temperature_repository.dart';
import '../../data/repositories/hive_symptom_repository.dart';
import '../../data/repositories/hive_user_repository.dart';
import '../../domain/repositories/period_repository.dart';
import '../../domain/repositories/temperature_repository.dart';
import '../../domain/repositories/symptom_repository.dart';
import '../../domain/repositories/user_repository.dart';

final periodRepositoryProvider = Provider<IPeriodRepository>((ref) {
  return HivePeriodRepository();
});

final temperatureRepositoryProvider = Provider<ITemperatureRepository>((ref) {
  return HiveTemperatureRepository();
});

final symptomRepositoryProvider = Provider<ISymptomRepository>((ref) {
  return HiveSymptomRepository();
});

final userRepositoryProvider = Provider<IUserRepository>((ref) {
  return HiveUserRepository();
});
