import 'package:dartz/dartz.dart';

import '../repositories/user_repository.dart';
import '../../../../core/errors/failure.dart';
import '../../../../core/usecases/usecase.dart';

class CheckUserRoleParams {
  final String userId;
  final String role;

  CheckUserRoleParams({required this.userId, required this.role});
}

class CheckUserRoleUseCase implements UseCase<bool, CheckUserRoleParams> {
  final UserRepository repository;

  CheckUserRoleUseCase(this.repository);

  @override
  Future<Either<Failure, bool>> call(CheckUserRoleParams params) {
    return repository.hasRole(params.userId, params.role);
  }
}