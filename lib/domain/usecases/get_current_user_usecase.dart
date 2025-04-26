import 'package:dartz/dartz.dart';

import '../entities/user.dart';
import '../repositories/auth_repository.dart';
import '../../core/errors/failure.dart';
import '../../core/usecases/usecase.dart';

class GetCurrentUserUseCase implements UseCase<User?, NoParams> {
  final AuthRepository repository;

  GetCurrentUserUseCase(this.repository);

  @override
  Future<Either<Failure, User?>> call(NoParams params) {
    return repository.getCurrentUser();
  }
}