import 'package:dartz/dartz.dart';

import '../../domain/entities/auth_result.dart';
import '../../domain/entities/user.dart';
import '../../domain/repositories/auth_repository.dart';
import '../datasources/auth_remote_datasource.dart';
import '../../core/errors/failure.dart';
import '../../core/network/network_info.dart';

class AuthRepositoryImpl implements AuthRepository {
  final AuthRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  AuthRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Stream<AuthResult> get authStateChanges {
    return remoteDataSource.authStateChanges.map(
          (authModel) => authModel.toDomain(),
    );
  }

  @override
  Future<Either<Failure, User?>> getCurrentUser() async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.getCurrentUser();
        return Right(userModel?.toDomain());
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Failed to get current user: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> signInWithEmailAndPassword(
      String username,
      String password,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final authModel = await remoteDataSource.signInWithEmailAndPassword(
          username,
          password,
        );
        return Right(authModel.toDomain());
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Sign in failed: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }

  @override
  Future<Either<Failure, AuthResult>> signUpWithEmailAndPassword(
      String email,
      String password,
      String? displayName,
      ) async {
    if (await networkInfo.isConnected) {
      try {
        final authModel = await remoteDataSource.signUpWithEmailAndPassword(
          email,
          password,
          displayName,
        );
        return Right(authModel.toDomain());
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Sign up failed: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> signOut() async {
    try {
      await remoteDataSource.signOut();
      return const Right(null);
    } on Failure catch (failure) {
      return Left(failure);
    } catch (e) {
      return Left(ServerFailure(
        message: 'Sign out failed: ${e.toString()}',
      ));
    }
  }

  @override
  Future<Either<Failure, void>> resetPassword(String email) async {
    if (await networkInfo.isConnected) {
      try {
        await remoteDataSource.resetPassword(email);
        return const Right(null);
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Password reset failed: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }
}