import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_simple/core/errors/failure.dart';

import '../../../../core/api/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../models/slider_model.dart';

abstract class SliderRemoteDataSource {
  Future<List<SliderModel>> getList();
}

class SliderRemoteDataSourceImpl extends SliderRemoteDataSource {
  final ApiClient _apiClient;

  SliderRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<List<SliderModel>> getList() async {
    try {

      final endpoint = "/sliders";
      final response = await _apiClient.get(endpoint,
          baseUrl: dotenv.env['DISNAKER_API_URL'] ?? ApiConstants.baseUrl,
      );

      if (response != null) {
        return response.map<SliderModel>((json) => SliderModel.fromJson(json)).toList();
      }

      throw ServerFailure(
        message: 'Slider not found',
      );
    } on Failure{
        rethrow;
    } catch (e) {
      throw ServerFailure(
        message: 'Failed to get slider: ${e.toString()}',
      );
    }
  }

}
