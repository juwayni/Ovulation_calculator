import '../models/symptom_model.dart';

abstract class ISymptomRepository {
  Future<List<SymptomModel>> getSymptoms();
  Future<void> saveSymptom(SymptomModel symptom);
  Future<void> deleteSymptom(DateTime date, String name);
}
