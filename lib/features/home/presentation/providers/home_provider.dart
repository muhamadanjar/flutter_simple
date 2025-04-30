import 'package:flutter_simple/core/usecases/usecase.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../core/errors/failure.dart';
import '../../../../presentation/providers/providers.dart';
import '../../../auth/domain/entities/user.dart';
import '../../data/datasources/slider_remote_datasource.dart';
import '../../data/repositories/slider_repository_impl.dart';
import '../../domain/entities/slider.dart';
import '../../domain/repositories/slider_repository.dart';
import '../../domain/usecase/slider_usecase.dart';
import 'home_state.dart';

part 'home_provider.g.dart';


@riverpod
SliderRemoteDataSource sliderRemoteDataSource(Ref ref) {
  return SliderRemoteDataSourceImpl(
    apiClient: ref.watch(apiClientProvider),
  );
}


@riverpod
SliderRepository sliderRepository(Ref ref) {
  return SliderRepositoryImpl(
    dataSource: ref.watch(sliderRemoteDataSourceProvider),
    networkInfo: ref.watch(networkInfoProvider),
  );
}


@riverpod
SliderUseCase sliderUseCase(Ref ref) {
  return SliderUseCase(ref.watch(sliderRepositoryProvider));
}





@riverpod
class HomeSliderNotifier extends _$HomeSliderNotifier {
  @override
  Future<HomeSliderState> build() async {
    final result = await ref.watch(sliderUseCaseProvider).call(NoParams());
    print("use case $result");
    return result.fold(
          (failure) => HomeSliderState.initial().copyWith(errorMessage: failure.message),
          (sliders) => HomeSliderState(sliders: sliders),
    );
  }

  Future<void> refresh() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() async {
      final result = await ref.read(sliderUseCaseProvider).call(NoParams());
      return result.fold(
            (failure) => HomeSliderState.initial().copyWith(errorMessage: failure.message),
            (sliders) => HomeSliderState(sliders: sliders),
      );
    });
  }

  void setCurrentSlide(int index) {
    final value = state.valueOrNull;
    if (value != null && index >= 0 && index < value.sliders.length) {
      state = AsyncData(value.copyWith(currentIndex: index));
    }
  }

  void nextSlide() {
    final value = state.valueOrNull;
    if (value != null) {
      final nextIndex = (value.currentIndex + 1) % value.sliders.length;
      setCurrentSlide(nextIndex);
    }
  }

  void previousSlide() {
    final value = state.valueOrNull;
    if (value != null) {
      final prevIndex = (value.currentIndex - 1 + value.sliders.length) % value.sliders.length;
      setCurrentSlide(prevIndex);
    }
  }

  void addSlide(SliderItem newSlide) {
    final value = state.valueOrNull;
    if (value != null) {
      state = AsyncData(value.copyWith(
        sliders: [...value.sliders, newSlide],
      ));
    }
  }

  void removeSlide(int id) {
    final value = state.valueOrNull;
    if (value != null) {
      final updatedSliders = value.sliders.where((s) => s.id != id).toList();
      state = AsyncData(value.copyWith(
        sliders: updatedSliders,
        currentIndex: value.currentIndex >= updatedSliders.length
            ? (updatedSliders.isEmpty ? 0 : updatedSliders.length - 1)
            : value.currentIndex,
      ));
    }
  }
}