
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

import '../../domain/entities/slider.dart';
part 'slider_model.g.dart';

@JsonSerializable()
class SliderModel  {
  final int id;
  final String title;
  @JsonKey(name: "image_url")
  final String imageUrl;
  final String description;

  SliderModel({
    required this.id,
    required this.title,
    required this.imageUrl,
    this.description = ''
  });

  SliderItem toDomain() {
    return SliderItem(
      id: id,
      title: title,
      imageUrl: imageUrl,
      description: ''
    );
  }

  // Factory from JSON
  factory SliderModel.fromJson(Map<String, dynamic> json) {
    return SliderModel(
      id: json['id'],
      title: json['title'] as String,
      imageUrl: json['image_url'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': title,
    };
  }
}