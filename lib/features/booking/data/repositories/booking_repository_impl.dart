import 'package:dartz/dartz.dart';
import 'package:flutter_simple/core/network/network_info.dart';
import 'package:flutter_simple/features/booking/domain/entities/available_time.dart';

import '../../../../core/errors/failure.dart';
import '../../domain/entities/booking.dart';
import '../../domain/repositories/booking_repository.dart';
import '../datasources/booking_local_datasource.dart';
import '../datasources/booking_remote_datasource.dart';

class BookingRepositoryImpl implements BookingRepository {
  final BookingRemoteDataSource remoteDataSource;
  final BookingLocalDataSource localDataSource;
  final NetworkInfo networkInfo;

  BookingRepositoryImpl({
    required this.remoteDataSource,
    required this.localDataSource,
    required this.networkInfo,
  });

  @override
  Future<Either<Failure, List<AvailableTime>>> getAvailableTimes(DateTime date) async {
    if (await networkInfo.isConnected) {
      try {
        final data = await remoteDataSource.fetchAvailableTimes(date);
        return Right(data);
      } on Failure catch(failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(message: 'Gagal ambil jadwal: $e'));
      }
    } else {
      // If the device is offline, try to get the cached data
      try{
        final data = await localDataSource.getCachedAvailableTimes(date);
        return Right(data);
      } catch (e){
        return Left(ServerFailure(message: 'Gagal ambil jadwal: $e'));
      }

    }
  }

  @override
  Future<Either<Failure, Unit>> submitSchedule(DateTime date, AvailableTime time) async {
    try {
      await remoteDataSource.submitSchedule(date, time);
      return const Right(unit);
    } catch (e) {
      return Left(ServerFailure(message: 'Gagal kirim jadwal: $e'));
    }
  }
}