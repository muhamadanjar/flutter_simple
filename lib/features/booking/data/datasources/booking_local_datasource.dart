import 'package:flutter_simple/features/booking/domain/entities/available_time.dart';

abstract class BookingLocalDataSource {
  Future<List<AvailableTime>> getCachedAvailableTimes(DateTime date);
  // This class will handle local data storage and retrieval for booking data.
  // It will use shared preferences or a local database to store booking information.
}

class BookingBookingDataSourceImpl implements BookingLocalDataSource {
  @override
  Future<List<AvailableTime>> getCachedAvailableTimes(DateTime date) {
    // TODO: implement getCachedAvailableTimes
    throw UnimplementedError();
  }
  // This class will implement the methods defined in BookingLocalDatasource.
  // It will use shared preferences or a local database to store booking information.
  // final SharedPreferences sharedPreferences;
  // final Database database;

  // BookingLocalDatasourceImpl({
  //   required this.sharedPreferences,
  //   required this.database,
  // });

  
}