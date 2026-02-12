import 'package:hive/hive.dart';
import '../../domain/repositories/user_repository.dart';
import '../models/user_model.dart';

class HiveUserRepository implements IUserRepository {
  static const String _boxName = 'user_box';

  Future<Box<UserModel>> _getBox() async {
    return await Hive.openBox<UserModel>(_boxName);
  }

  @override
  Future<UserModel?> getUser() async {
    final box = await _getBox();
    if (box.isEmpty) return null;
    return box.getAt(0);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    final box = await _getBox();
    await box.put(0, user);
  }

  @override
  Future<void> deleteUser() async {
    final box = await _getBox();
    await box.clear();
  }

  @override
  Future<void> resetAllData() async {
    await Hive.deleteBoxFromDisk(_boxName);
    await Hive.deleteBoxFromDisk('periods');
    await Hive.deleteBoxFromDisk('symptoms');
    await Hive.deleteBoxFromDisk('temperatures');
    await Hive.deleteBoxFromDisk('notes');
  }
}
