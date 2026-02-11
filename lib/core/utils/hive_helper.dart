import 'package:hive_flutter/hive_flutter.dart';
import '../../data/models/period_model.dart';
import '../../data/models/temperature_model.dart';
import '../../data/models/symptom_model.dart';
import '../../data/models/note_model.dart';

class HiveHelper {
  HiveHelper._();

  static Future<void> init() async {
    await Hive.initFlutter();

    // Register adapters
    Hive.registerAdapter(PeriodModelAdapter());
    Hive.registerAdapter(TemperatureModelAdapter());
    Hive.registerAdapter(SymptomModelAdapter());
    Hive.registerAdapter(NoteModelAdapter());
  }
}
