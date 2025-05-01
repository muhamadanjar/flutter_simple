import 'package:flutter_simple/features/training/data/datasources/training_datasource.dart';
import 'package:flutter_simple/features/training/domain/repositories/training_repository.dart';
import 'package:flutter_simple/features/training/domain/usecase/get_training_usecase.dart';
import 'package:flutter_simple/features/training/presentation/providers/training_state.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../presentation/providers/providers.dart';
import '../../data/repositories/training_repostory_impl.dart';

part 'training_provider.g.dart';

@riverpod
TrainingDataSource trainingRemoteDataSource(
    TrainingRemoteDataSourceRef ref) {
  return TrainingDataSourceImpl(
    apiClient: ref.watch(apiClientProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}

@riverpod
TrainingRepository trainingRepository(TrainingRepositoryRef ref) {
  return TrainingRepositoryImpl(
    remoteDataSource: ref.watch(trainingRemoteDataSourceProvider),
  );
}

@riverpod
class TrainingNotifier extends _$TrainingNotifier {
  late final GetTraining _getTraining;
  late final TrainingRepository _repo;


  @override
  TrainingState build() {
    _repo = ref.watch(trainingRepositoryProvider);
    _getTraining = GetTraining(_repo);
    return TrainingState.initial();
  }

  Future<void> loadTraining({bool refresh = false}) async {
    if (state.isLoading || state.isPaginating) return;

    final isFirstLoad = state.trainings.isEmpty || refresh;
    final nextPage = isFirstLoad ? 1 : state.page + 1;

    state = state.copyWith(
      isLoading: isFirstLoad,
      isPaginating: !isFirstLoad,
      error: null,
    );

    final result = await _repo.getList(page: nextPage, keyword: state.keyword);

    result.fold(
          (failure) {
        state = state.copyWith(
          isLoading: false,
          isPaginating: false,
          error: failure.message,
        );
      },
          (newUsers) {
        final allUsers = isFirstLoad ? newUsers : [...state.trainings, ...newUsers];
        final hasMore = newUsers.length == 10;

        state = state.copyWith(
          trainings: allUsers,
          isLoading: false,
          isPaginating: false,


        );
      },
    );
  }

  Future<void> searchTraining(String keyword) async {
    state = state.copyWith(
      keyword: keyword,
      page: 1,
      trainings: [],
      hasMore: true,
      error: null,
    );

    await loadTraining(refresh: true);
  }
}