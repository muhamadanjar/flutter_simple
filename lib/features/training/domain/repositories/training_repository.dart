
import 'package:dartz/dartz.dart';
import 'package:flutter_simple/core/errors/failure.dart';

import '../entities/training.dart';

abstract class TrainingRepository {
  Future<Either<Failure, List<Training>>> getList({ required int page, required String keyword,});
}