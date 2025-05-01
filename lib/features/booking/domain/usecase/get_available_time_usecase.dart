import 'package:dartz/dartz.dart';
import 'package:flutter_simple/features/booking/domain/repositories/booking_repository.dart';

import '../../../../core/errors/failure.dart';
import '../entities/available_time.dart';

class GetAvailableTimesUseCase {
  final BookingRepository repository;

  GetAvailableTimesUseCase(this.repository);

  Future<Either<Failure, List<AvailableTime>>> call(DateTime date) {
    return repository.getAvailableTimes(date);
  }
}
