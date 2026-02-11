import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'note_model.freezed.dart';
part 'note_model.g.dart';

@freezed
class NoteModel with _$NoteModel {
  @HiveType(typeId: 3, adapterName: 'NoteModelAdapter')
  const factory NoteModel({
    @HiveField(0) required DateTime date,
    @HiveField(1) required String content,
  }) = _NoteModel;

  factory NoteModel.fromJson(Map<String, dynamic> json) => _$NoteModelFromJson(json);
}
