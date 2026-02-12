import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/temperature_model.dart';
import 'repository_providers.dart';

final temperaturesProvider = FutureProvider<List<TemperatureModel>>((
  ref,
) async {
  final repository = ref.watch(temperatureRepositoryProvider);
  return repository.getTemperatures();
});
