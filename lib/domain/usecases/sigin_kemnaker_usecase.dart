import 'package:dartz/dartz.dart';

import '../../../core/errors/failure.dart';
import '../../../core/usecases/usecase.dart';
import '../entities/auth_result.dart';
import '../repositories/auth_repository.dart';

class SignInWithKemnakerUseCase implements UseCase<AuthResult, NoParams> {
  final AuthRepository repository;

  SignInWithKemnakerUseCase(this.repository);

  @override
  Future<Either<Failure, AuthResult>> call(NoParams params) {
    return repository.signInWithKemnaker();
  }
}