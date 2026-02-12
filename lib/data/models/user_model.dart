import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hive/hive.dart';

part 'user_model.freezed.dart';
part 'user_model.g.dart';

@freezed
@HiveType(typeId: 4)
class UserModel with _$UserModel {
  const factory UserModel({
    @HiveField(0) required String id,
    @HiveField(1) required String name,
    @HiveField(2) required int age,
    @HiveField(3) required int cycleLength,
    @HiveField(4) required int periodLength,
    @HiveField(5) @Default(false) bool onboardingCompleted,
    @HiveField(6) @Default(false) bool medicalDisclaimerAccepted,
  }) = _UserModel;

  factory UserModel.fromJson(Map<String, dynamic> json) =>
      _$UserModelFromJson(json);
}
