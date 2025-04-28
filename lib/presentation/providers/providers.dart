import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/api/api_client.dart';
import '../../core/services/oauth2_service.dart';
import '../../data/datasources/auth_remote_datasource.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../data/repositories/auth_repository_impl.dart';
import '../../data/repositories/user_repository_impl.dart';
import '../../domain/repositories/auth_repository.dart';
import '../../domain/repositories/user_repository.dart';
import '../../domain/usecases/sigin_google_usecase.dart';
import '../../domain/usecases/sigin_kemnaker_usecase.dart';
import '../../domain/usecases/signin_apple_usecase.dart';
import '../../domain/usecases/signin_microsoft_usecase.dart';
import '../../domain/usecases/signin_usecase.dart';
import '../../domain/usecases/signup_usecase.dart';
import '../../domain/usecases/signout_usecase.dart';
import '../../domain/usecases/get_current_user_usecase.dart';
import '../../domain/usecases/check_user_role_usecase.dart';
import '../../core/network/network_info.dart';

part 'providers.g.dart';

// API client provider
@riverpod
ApiClient apiClient(Ref ref) {
  return ApiClient();
}

// OAuth2 service provider
@riverpod
OAuth2Service oauth2Service(Ref ref) {
  return OAuth2Service(apiClient: ref.watch(apiClientProvider));
}

// Network info provider
@riverpod
NetworkInfo networkInfo(Ref ref) {
  return NetworkInfoImpl();
}

// DataSource providers
@riverpod
AuthRemoteDataSource authRemoteDataSource(Ref ref) {
  return AuthRemoteDataSourceImpl(
    apiClient: ref.watch(apiClientProvider),
    oauth2Service: ref.watch(oauth2ServiceProvider),
  );
}

@riverpod
UserRemoteDataSource userRemoteDataSource(Ref ref) {
  return UserRemoteDataSourceImpl(
    apiClient: ref.watch(apiClientProvider),
  );
}

// Repository providers
@riverpod
AuthRepository authRepository(Ref ref) {
  return AuthRepositoryImpl(
    remoteDataSource: ref.watch(authRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

@riverpod
UserRepository userRepository(Ref ref) {
  return UserRepositoryImpl(
    remoteDataSource: ref.watch(userRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

// UseCase providers
@riverpod
SignInUseCase signInUseCase(Ref ref) {
  return SignInUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignUpUseCase signUpUseCase(Ref ref) {
  return SignUpUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignOutUseCase signOutUseCase(Ref ref) {
  return SignOutUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
GetCurrentUserUseCase getCurrentUserUseCase(Ref ref) {
  return GetCurrentUserUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
CheckUserRoleUseCase checkUserRoleUseCase(Ref ref) {
  return CheckUserRoleUseCase(ref.watch(userRepositoryProvider));
}

// OAuth Use Cases
@riverpod
SignInWithGoogleUseCase signInWithGoogleUseCase(Ref ref) {
  return SignInWithGoogleUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignInWithMicrosoftUseCase signInWithMicrosoftUseCase(Ref ref) {
  return SignInWithMicrosoftUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignInWithAppleUseCase signInWithAppleUseCase(Ref ref) {
  return SignInWithAppleUseCase(ref.watch(authRepositoryProvider));
}

@riverpod
SignInWithKemnakerUseCase signInWithKemnakerUseCase(Ref ref) {
  return SignInWithKemnakerUseCase(ref.watch(authRepositoryProvider));
}
