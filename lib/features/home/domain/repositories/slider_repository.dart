import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/slider.dart';

abstract class SliderRepository {

  Future<Either<Failure, List<SliderItem>>> getList();
}