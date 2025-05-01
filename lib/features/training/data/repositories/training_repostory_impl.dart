
import 'package:dartz/dartz.dart';
import 'package:flutter_simple/core/errors/failure.dart';
import 'package:flutter_simple/features/training/domain/repositories/training_repository.dart';

import '../../domain/entities/training.dart';
import '../datasources/training_datasource.dart';

class TrainingRepositoryImpl extends TrainingRepository{
  final TrainingDataSource remoteDataSource;

  TrainingRepositoryImpl({required this.remoteDataSource});

  @override
  Future<Either<Failure, List<Training>>> getList({required String keyword, required int page}) async {
    try {
      final result = await remoteDataSource.getList();
      return Right(result);
    } on Failure catch (e) {
      return Left(e);
    } catch (e) {
      return Left(ServerFailure(message: e.toString()));
    }
  }
}