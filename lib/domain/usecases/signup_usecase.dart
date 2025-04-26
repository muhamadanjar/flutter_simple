import 'package:dartz/dartz.dart';

import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';

class SignUpParams {
  final String email;
  final String password;
  final String? displayName;

  SignUpParams({
    required this.email,
    required this.password,
    this.displayName,
  });
}

class SignUpUseCase implements UseCase<AuthResult, SignUpParams> {
  final AuthRepository repository;

  SignUpUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(SignUpParams params) {
    return repository.signUpWithEmailAndPassword(
      params.email,
      params.password,
      params.displayName,
    );
  }
}
