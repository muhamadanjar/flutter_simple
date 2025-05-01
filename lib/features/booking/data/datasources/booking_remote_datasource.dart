import 'dart:convert';

import '../../../../core/api/api_client.dart';
import '../../domain/entities/available_time.dart';
import '../../domain/entities/booking.dart';
import '../models/available_time_model.dart';
import '../models/booking_model.dart';

abstract class BookingRemoteDataSource {
  /// Get list of bookings
  // Future<List<BookingModel>> getList();
  /// Get booking detail by id
  // Future<BookingModel> getDetail(String id);
  /// Create a new booking
  // Future<BookingModel> create(Booking booking);
  /// Update an existing booking
  // Future<BookingModel> update(Booking booking);
  /// Delete a booking by id
  // Future<void> delete(String id);
  Future<List<AvailableTimeModel>> fetchAvailableTimes(DateTime date);
  Future<void> submitSchedule(DateTime date, AvailableTime time);
}

class BookingRemoteDataSourceImpl extends BookingRemoteDataSource {

  final ApiClient _apiClient;

  BookingRemoteDataSourceImpl({
    required ApiClient apiClient,
  }) : _apiClient = apiClient;

  // @override
  // Future<dynamic> create(booking) {
  //   // TODO: implement create
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<void> delete(String id) {
  //   // TODO: implement delete
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<dynamic> getDetail(String id) {
  //   // TODO: implement getDetail
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<List<dynamic>> getList() {
  //   // TODO: implement getList
  //   throw UnimplementedError();
  // }
  //
  // @override
  // Future<dynamic> update(booking) {
  //   // TODO: implement update
  //   throw UnimplementedError();
  // }

  Future<List<AvailableTimeModel>> fetchAvailableTimes(DateTime date) async {
    final response = await _apiClient.get(
      'lookups-items?type=time_antrian&date=${date.toIso8601String()}',
      baseUrl: "https://disnakertrans.sukabumikab.go.id/",
    );

    if (response.statusCode == 200) {
      final data = json.decode(response) as List;
      return data.map((e) => AvailableTimeModel.fromJson(e)).toList();
    } else {
      throw Exception('Failed to load schedule');
    }
  }

  Future<void> submitSchedule(DateTime date, AvailableTime time) async {
    final response = await _apiClient.post('/schedule',
      data: jsonEncode({
        'date': date.toIso8601String(),
        'start': time.start,
        'end': time.end,
      }),
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to submit schedule');
    }
  }
}