import 'package:freezed_annotation/freezed_annotation.dart';
part 'booking_state.freezed.dart';

@freezed
class BookingState with _$BookingState {
  const BookingState._();

  const factory BookingState({
    required String bookingDetails,
    required DateTime bookingDate,
    required String bookingTime,
    @Default(false) bool isLoading,
    String? errorMessage,
  }) = _BookingState;

  factory BookingState.initial() => BookingState(
        bookingDetails: '',
        bookingDate: DateTime.now(),
        bookingTime: '',
      );

}