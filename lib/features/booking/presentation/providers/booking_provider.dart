
import 'package:flutter_simple/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../presentation/providers/providers.dart';
import '../../data/datasources/booking_local_datasource.dart';
import '../../data/datasources/booking_remote_datasource.dart';
import '../../domain/entities/available_time.dart';
import '../../domain/repositories/booking_repository.dart';
import '../../domain/usecase/booking_usecase.dart';
import 'booking_state.dart';
part 'booking_provider.g.dart';

@riverpod
BookingRemoteDataSource bookingRemoteDataSource(Ref ref) {
  return BookingRemoteDataSourceImpl(
    apiClient: ref.watch(apiClientProvider),
  );
}

@riverpod
BookingLocalDataSource bookingLocalDataSource(Ref ref) {
  return BookingBookingDataSourceImpl(
    
  );
}

@riverpod
BookingRepository bookingRepository(Ref ref) {
  return BookingRepositoryImpl(
    remoteDataSource: ref.watch(bookingRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider), 
    localDataSource: ref.watch(bookingLocalDataSourceProvider),
  );
}

@riverpod
class BookingNotifier extends _$BookingNotifier {

  @override
  BookingState build() {
    return BookingState.initial();
  }

  void setBookingDetails(String details) {
    state = state.copyWith(bookingDetails: details);
  }

  void setBookingDate(DateTime date) {
    state = state.copyWith(bookingDate: date);
  }

  void setBookingTime(String time) {
    state = state.copyWith(bookingTime: time);
  }

  Future<void> loadInitals() async {
    state = state.copyWith(isLoading: true, errorMessage: null);

    final usecase = ref.read(bookingUseCaseProvider);

  }

}


@riverpod
Future<List<AvailableTime>> availableTimes(AvailableTimesRef ref, DateTime date) async {
  final repo = ref.watch(bookingRepositoryProvider);
  final result = await repo.getAvailableTimes(date);

  return result.fold(
        (failure) => throw Exception(failure.message),
        (data) => data,
  );
}


final selectedDateProvider = StateProvider<DateTime?>((ref) => null);
final selectedTimeProvider = StateProvider<AvailableTime?>((ref) => null);

@riverpod
BookingUseCase bookingUseCase(Ref ref) {
  return BookingUseCase(ref.watch(bookingRepositoryProvider));
}