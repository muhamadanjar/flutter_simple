import 'package:dartz/dartz.dart';

import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';

class SignInParams {
  final String username;
  final String password;

  SignInParams({required this.username, required this.password});
}

class SignInUseCase implements UseCase<AuthResult, SignInParams> {
  final AuthRepository repository;

  SignInUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(SignInParams params) {
    return repository.signInWithEmailAndPassword(
      params.username,
      params.password,
    );
  }
}