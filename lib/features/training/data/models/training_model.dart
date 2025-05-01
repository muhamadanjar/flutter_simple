import 'package:flutter_simple/features/training/domain/entities/training.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

@JsonSerializable()
class TrainingModel extends Training {
  final DateTime createdAt;
  final DateTime updatedAt;
  TrainingModel({
    required super.id,
    required super.name,
    required super.description,
    required super.imageUrl,
    required super.videoUrl,
    required super.duration,
    required super.equipment,
    required this.createdAt,
    required this.updatedAt
  });

  factory TrainingModel.fromJson(Map<String, dynamic> json) {
    return TrainingModel(
      id: json['id'],
      name: json['name'],
      description: json['description'],
      imageUrl: json['imageUrl'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      videoUrl: '', duration: 0, equipment: [],
    );
  }


  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'imageUrl': imageUrl,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
    };
  }





}