// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'slider_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SliderModel _$SliderModelFromJson(Map<String, dynamic> json) => SliderModel(
  id: (json['id'] as num).toInt(),
  title: json['title'] as String,
  imageUrl: json['image_url'] as String,
  description: json['description'] as String? ?? '',
);

Map<String, dynamic> _$SliderModelToJson(SliderModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'image_url': instance.imageUrl,
      'description': instance.description,
    };
