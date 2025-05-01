import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/training.dart';
import '../repositories/training_repository.dart';

class GetTraining {
  final TrainingRepository repository;

  GetTraining(this.repository);

  Future<Either<Failure, List<Training>>> call() async {
    return await repository.getList(
      page: 1,
      keyword: '',
    );
  }
}