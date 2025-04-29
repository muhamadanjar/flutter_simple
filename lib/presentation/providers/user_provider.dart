import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../features/auth/domain/entities/user.dart';
import '../../features/auth/domain/repositories/user_repository.dart';
import 'providers.dart';
import 'auth_provider.dart';

part 'user_provider.g.dart';

// User notifier - handles user data operations
@riverpod
class UserNotifier extends _$UserNotifier {
  late UserRepository _userRepository;

  @override
  FutureOr<User?> build() {
    _userRepository = ref.read(userRepositoryProvider);

    // Watch current user and refetch user data when it changes
    final currentUser = ref.watch(currentUserProvider);

    // If we have a current user in the future, refetch from user repository
    return currentUser.whenData((user) async {
      if (user == null) {
        return null;
      }

      final result = await _userRepository.getUserById(user.id);
      return result.fold(
            (failure) => user, // Return current user if fetch fails
            (updatedUser) => updatedUser,
      );
    }).value;
  }

  // Update user information (display name, photo URL)
  Future<User?> updateUserInfo({
    required String userId,
    String? displayName,
    String? photoUrl,
  }) async {
    state = const AsyncValue.loading();

    final result = await _userRepository.updateUserInfo(
      userId: userId,
      displayName: displayName,
      photoUrl: photoUrl,
    );

    state = await result.fold(
          (failure) {
        return AsyncValue.error(failure, StackTrace.current);
      },
          (user) {
        return AsyncValue.data(user);
      },
    );

    return state.value;
  }

  // Update user role (for role-based authorization)
  Future<User?> updateUserRole({
    required String userId,
    required String role,
  }) async {
    state = const AsyncValue.loading();

    final result = await _userRepository.updateUserRole(
      userId: userId,
      role: role,
    );

    state = await result.fold(
          (failure) {
        return AsyncValue.error(failure, StackTrace.current);
      },
          (user) {
        return AsyncValue.data(user);
      },
    );

    return state.value;
  }
}

// Single user provider - fetches a user by ID
@riverpod
Future<User?> userById(UserByIdRef ref, String userId) async {
  final userRepository = ref.watch(userRepositoryProvider);
  final result = await userRepository.getUserById(userId);

  return result.fold(
        (failure) => null,
        (user) => user,
  );
}