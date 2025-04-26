import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../../core/errors/failure.dart';

abstract class UserRepository {
  /// Get user information by id
  Future<Either<Failure, User>> getUserById(String userId);

  /// Update user information
  Future<Either<Failure, User>> updateUserInfo({
    required String userId,
    String? displayName,
    String? photoUrl,
  });

  /// Update user role (untuk authorization)
  Future<Either<Failure, User>> updateUserRole({
    required String userId,
    required String role,
  });

  /// Check if user has specific role
  Future<Either<Failure, bool>> hasRole(String userId, String role);
}