import 'package:dartz/dartz.dart';

import '../entities/auth_result.dart';
import '../entities/user.dart';
import '../../core/errors/failure.dart';

abstract class AuthRepository {
  /// Stream untuk memantau status autentikasi
  Stream<AuthResult> get authStateChanges;

  /// Get current user
  Future<Either<Failure, User?>> getCurrentUser();

  /// Sign in dengan email dan password
  Future<Either<Failure, AuthResult>> signInWithEmailAndPassword(
      String username,
      String password
      );

  /// Sign up dengan email dan password
  Future<Either<Failure, AuthResult>> signUpWithEmailAndPassword(
      String username,
      String password,
      String? displayName
      );

  /// Sign out
  Future<Either<Failure, void>> signOut();

  /// Sign in dengan Google OAuth2
  Future<Either<Failure, AuthResult>> signInWithGoogle();

  /// Sign in dengan Microsoft OAuth2
  Future<Either<Failure, AuthResult>> signInWithMicrosoft();

  /// Sign in dengan Apple OAuth2
  Future<Either<Failure, AuthResult>> signInWithApple();
  Future<Either<Failure, AuthResult>> signInWithKemnaker();


  /// Reset password
  Future<Either<Failure, void>> resetPassword(String email);
}

