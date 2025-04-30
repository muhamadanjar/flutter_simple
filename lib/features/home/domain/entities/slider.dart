import 'package:equatable/equatable.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'slider.freezed.dart';

@freezed
class SliderItem with _$SliderItem {
  const factory SliderItem({
    required int id,
    required String imageUrl,
    required String title,
    required String description,
  }) = _SliderItem;



}
