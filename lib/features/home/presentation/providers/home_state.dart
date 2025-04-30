import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/slider.dart';

part 'home_state.freezed.dart';

@freezed
class HomeSliderState with _$HomeSliderState {
  const factory HomeSliderState({
    required List<SliderItem> sliders,
    @Default(0) int currentIndex,
    String? errorMessage,
  }) = _HomeSliderState;


  factory HomeSliderState.initial() => const HomeSliderState(sliders: [], currentIndex: 0);
}
