import 'package:dartz/dartz.dart';

import '../../domain/entities/user.dart';
import '../../domain/repositories/user_repository.dart';
import '../../data/datasources/user_remote_datasource.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/network/network_info.dart';

class UserRepositoryImpl implements UserRepository {
  final UserRemoteDataSource remoteDataSource;
  final NetworkInfo networkInfo;

  UserRepositoryImpl({
    required this.remoteDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, User>> getUserById(String userId) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.getUserById(userId);
        return Right(userModel.toDomain());
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Failed to get user: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserInfo({
    required String userId,
    String? displayName,
    String? photoUrl,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.updateUserInfo(
          userId: userId,
          displayName: displayName,
          photoUrl: photoUrl,
        );
        return Right(userModel.toDomain());
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Failed to update user info: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }

  @override
  Future<Either<Failure, User>> updateUserRole({
    required String userId,
    required String role,
  }) async {
    if (await networkInfo.isConnected) {
      try {
        final userModel = await remoteDataSource.updateUserRole(
          userId: userId,
          role: role,
        );
        return Right(userModel.toDomain());
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Failed to update user role: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }

  @override
  Future<Either<Failure, bool>> hasRole(String userId, String role) async {
    if (await networkInfo.isConnected) {
      try {
        final hasRole = await remoteDataSource.hasRole(userId, role);
        return Right(hasRole);
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Failed to check user role: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }
}