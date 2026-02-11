import 'package:hive/hive.dart';
import '../../domain/repositories/symptom_repository.dart';
import '../models/symptom_model.dart';

class HiveSymptomRepository implements ISymptomRepository {
  static const String boxName = 'symptoms';

  Future<Box<SymptomModel>> _getBox() async {
    return await Hive.openBox<SymptomModel>(boxName);
  }

  @override
  Future<List<SymptomModel>> getSymptoms() async {
    final box = await _getBox();
    return box.values.toList();
  }

  @override
  Future<void> saveSymptom(SymptomModel symptom) async {
    final box = await _getBox();
    await box.put('${symptom.date.toIso8601String()}_${symptom.name}', symptom);
  }

  @override
  Future<void> deleteSymptom(DateTime date, String name) async {
    final box = await _getBox();
    await box.delete('${date.toIso8601String()}_$name');
  }
}
