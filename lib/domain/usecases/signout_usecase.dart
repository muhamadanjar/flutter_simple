import 'package:dartz/dartz.dart';

import '../repositories/auth_repository.dart';
import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';

class SignOutUseCase implements UseCase<void, NoParams> {
  final AuthRepository repository;

  SignOutUseCase(this.repository);

  @override
  Future<Either<Failure, void>> call(NoParams params) {
    return repository.signOut();
  }
}
