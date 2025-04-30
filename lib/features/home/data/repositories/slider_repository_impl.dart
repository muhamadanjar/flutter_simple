
import 'package:dartz/dartz.dart';
import 'package:flutter_simple/core/errors/failure.dart';
import 'package:flutter_simple/features/home/data/datasources/slider_remote_datasource.dart';
import 'package:flutter_simple/features/home/domain/entities/slider.dart';
import 'package:flutter_simple/features/home/domain/repositories/slider_repository.dart';

import '../../../../core/network/network_info.dart';

class SliderRepositoryImpl extends SliderRepository {
  final NetworkInfo networkInfo;
  final SliderRemoteDataSource dataSource;
  SliderRepositoryImpl({ required this.networkInfo, required this.dataSource});

  @override
  Future<Either<Failure, List<SliderItem>>> getList() async{
    if (await networkInfo.isConnected) {
      try {
        final result = await dataSource.getList();
        final sliders = result.map<SliderItem>((json) => json.toDomain()).toList();
        return Right(sliders);
      } on Failure catch (failure) {
        return Left(failure);
      } catch (e) {
        return Left(ServerFailure(
          message: 'Sign in failed: ${e.toString()}',
        ));
      }
    } else {
      return const Left(ServerFailure(
        message: 'No internet connection',
      ));
    }
  }


}