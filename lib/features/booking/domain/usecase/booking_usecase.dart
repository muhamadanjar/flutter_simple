import 'package:dartz/dartz.dart';
import 'package:flutter_simple/core/usecases/usecase.dart';

import '../../../../core/errors/failure.dart';
import '../../presentation/providers/booking_state.dart';
import '../repositories/booking_repository.dart';

class BookingUseCase extends UseCase<BookingState, NoParams> {
  final BookingRepository repository;
  BookingUseCase(this.repository);

  @override
  Future<Either<Failure, BookingState>> call(NoParams params) {
    // TODO: implement call
    throw UnimplementedError();
  }
//
//   @override
//   Future<Either<Failure, BookingState>> call(NoParams params) async {
//     final result = await repository.getList();
//     return result.fold(
//       (failure) => Left(failure),
//       (bookingState) => Right(
//           BookingState(
//             bookingDetails: bookingState.bookingDetails,
//             bookingDate: bookingState.bookingDate,
//             bookingTime: bookingState.bookingTime,
//             isLoading: false,
//             errorMessage: null,
//           )
//       ),
//
//     );
//   }
}