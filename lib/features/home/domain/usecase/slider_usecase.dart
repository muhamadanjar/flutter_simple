import 'package:dartz/dartz.dart';
import 'package:flutter_simple/core/errors/failure.dart';
import 'package:flutter_simple/core/usecases/usecase.dart';
import 'package:flutter_simple/features/home/domain/entities/slider.dart';
import 'package:flutter_simple/features/home/domain/repositories/slider_repository.dart';

class SliderUseCase extends UseCase<List<SliderItem>, NoParams> {
  final SliderRepository repository;

  SliderUseCase(this.repository);

  @override
  Future<Either<Failure, List<SliderItem>>> call(NoParams params) {
    return repository.getList();
  }
}