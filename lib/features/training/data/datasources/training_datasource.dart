import '../../../../core/api/api_client.dart';
import '../../../../core/network/network_info.dart';
import '../models/training_model.dart';

abstract class TrainingDataSource{
  Future<List<TrainingModel>> getList();
}

class TrainingDataSourceImpl implements TrainingDataSource {
  final ApiClient apiClient;
  final NetworkInfo networkInfo;
  TrainingDataSourceImpl({
    required this.apiClient,
    required this.networkInfo,
  });


  @override
  Future<List<TrainingModel>> getList() async {
    final result = await apiClient.get('/training', queryParameters: {
      'page': 1,
      'keyword': '',
    });
    if (result.statusCode == 200) {
      final List<TrainingModel> trainings = [];
      for (var item in result.data) {
        trainings.add(TrainingModel.fromJson(item));
      }
      return trainings;
    } else {
      throw Exception('Failed to load training');
    }
  }
}