
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failure.dart';
import '../entities/available_time.dart';
import '../entities/booking.dart';

abstract class BookingRepository {
  // Future<Either<Failure, List<Booking>>> getList();
  // Future<Either<Failure, Booking>> getDetail(String id);
  // Future<Either<Failure, Booking>> create(Booking booking);
  // Future<Either<Failure, Booking>> update(Booking booking);
  // Future<Either<Failure, Booking>> delete(String id);

  Future<Either<Failure, List<AvailableTime>>> getAvailableTimes(DateTime date);
  Future<Either<Failure, Unit>> submitSchedule(DateTime date, AvailableTime time);


}