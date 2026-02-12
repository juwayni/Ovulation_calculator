import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/user_model.dart';
import '../../domain/repositories/user_repository.dart';
import 'repository_providers.dart';

final userProvider = FutureProvider<UserModel?>((ref) async {
  final repository = ref.watch(userRepositoryProvider);
  return repository.getUser();
});

class UserNotifier extends StateNotifier<AsyncValue<void>> {
  final IUserRepository _repository;
  final Ref _ref;

  UserNotifier(this._repository, this._ref)
    : super(const AsyncValue.data(null));

  Future<void> updateUser(UserModel user) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await _repository.saveUser(user);
      _ref.invalidate(userProvider);
    });
  }
}

final userActionProvider =
    StateNotifierProvider<UserNotifier, AsyncValue<void>>((ref) {
      final repository = ref.watch(userRepositoryProvider);
      return UserNotifier(repository, ref);
    });
