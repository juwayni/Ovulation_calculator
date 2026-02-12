import '../../data/models/user_model.dart';

abstract class IUserRepository {
  Future<UserModel?> getUser();
  Future<void> saveUser(UserModel user);
  Future<void> deleteUser();
  Future<void> resetAllData();
}
