// lib/presentation/providers/auth_provider.dart
import 'dart:async';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/usecases/usecase.dart';
import '../../domain/entities/auth_result.dart';
import '../../domain/entities/user.dart';
import '../../domain/usecases/signin_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/check_user_role_usecase.dart';
import 'providers.dart';

part 'auth_provider.g.dart';

// Auth state provider - streams the current auth state
@riverpod
Stream<AuthResult> authState(AuthStateRef ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChanges;
}

// Auth notifier - handles auth actions like sign in, sign up, sign out
@riverpod
class AuthNotifier extends _$AuthNotifier {
  @override
  FutureOr<void> build() {
    // Initial state
    return null;
  }

  // Sign in with email and password
  Future<AuthResult> signIn(String username, String password) async {
    state = const AsyncValue.loading();

    final signInUseCase = ref.read(signInUseCaseProvider);
    final params = SignInParams(username: username, password: password);

    final result = await signInUseCase.call(params);

    return result.fold(
          (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return AuthResult.unauthenticated(errorMessage: failure.message);
      },
          (authResult) {
        state = const AsyncValue.data(null);
        return authResult;
      },
    );
  }

  // Sign up with email and password
  Future<AuthResult> signUp(String email, String password, String? displayName) async {
    state = const AsyncValue.loading();

    final signUpUseCase = ref.read(signUpUseCaseProvider);
    final params = SignUpParams(
      email: email,
      password: password,
      displayName: displayName,
    );

    final result = await signUpUseCase.call(params);

    return result.fold(
          (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return AuthResult.unauthenticated(errorMessage: failure.message);
      },
          (authResult) {
        state = const AsyncValue.data(null);
        return authResult;
      },
    );
  }

  // Sign out
  Future<bool> signOut() async {
    state = const AsyncValue.loading();

    final signOutUseCase = ref.read(signOutUseCaseProvider);

    final result = await signOutUseCase.call(const NoParams());

    return result.fold(
          (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return false;
      },
          (_) {
        state = const AsyncValue.data(null);
        return true;
      },
    );
  }

  // Sign in with Google
  Future<AuthResult> signInWithGoogle() async {
    state = const AsyncValue.loading();

    final signInWithGoogleUseCase = ref.read(signInWithGoogleUseCaseProvider);

    final result = await signInWithGoogleUseCase.call(const NoParams());

    return result.fold(
          (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return AuthResult.unauthenticated(errorMessage: failure.message);
      },
          (authResult) {
        state = const AsyncValue.data(null);
        return authResult;
      },
    );
  }

  Future<AuthResult> signInWithMicrosoft() async {
    state = const AsyncValue.loading();

    final signInWithMicrosoftUseCase = ref.read(signInWithMicrosoftUseCaseProvider);

    final result = await signInWithMicrosoftUseCase.call(const NoParams());

    return result.fold(
          (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return AuthResult.unauthenticated(errorMessage: failure.message);
      },
          (authResult) {
        state = const AsyncValue.data(null);
        return authResult;
      },
    );
  }

  Future<AuthResult> signInWithApple() async {
    state = const AsyncValue.loading();

    final signInWithAppleUseCase = ref.read(signInWithAppleUseCaseProvider);

    final result = await signInWithAppleUseCase.call(const NoParams());

    return result.fold(
          (failure) {
        state = AsyncValue.error(failure, StackTrace.current);
        return AuthResult.unauthenticated(errorMessage: failure.message);
      },
          (authResult) {
        state = const AsyncValue.data(null);
        return authResult;
      },
    );
  }
}

// User role provider - checks if a user has a specific role
@riverpod
Future<bool> hasRole(HasRoleRef ref, String userId, String role) {
  final checkUserRoleUseCase = ref.watch(checkUserRoleUseCaseProvider);
  final params = CheckUserRoleParams(userId: userId, role: role);

  return checkUserRoleUseCase.call(params).then(
        (result) => result.fold(
          (failure) => false,
          (hasRole) => hasRole,
    ),
  );
}

// Current user provider - provides the current authenticated user
@riverpod
Future<User?> currentUser(CurrentUserRef ref) async {
  // Listen to auth state changes
  ref.watch(authStateProvider);

  final getCurrentUserUseCase = ref.watch(getCurrentUserUseCaseProvider);
  final result = await getCurrentUserUseCase.call(const NoParams());

  return result.fold(
        (failure) => null,
        (user) => user,
  );
}

// Authorization provider - for role-based access control
@riverpod
class AuthorizationNotifier extends _$AuthorizationNotifier {
  @override
  FutureOr<bool> build(String requiredRole) async {
    final user = await ref.watch(currentUserProvider.future);

    if (user == null) {
      return false;
    }

    if (user.roles.isEmpty) {
      return false;
    }

    return user.roles.any((role) => role.name == requiredRole);
  }
}