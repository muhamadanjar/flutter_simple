import 'package:json_annotation/json_annotation.dart';

import '../../domain/entities/role.dart';

part 'role_model.g.dart';

@JsonSerializable()
class RoleModel {
  final String id;
  final String name;

  RoleModel({
    required this.id,
    required this.name,
  });

  // Convert to domain entity
  Role toDomain() {
    return Role(
      id: id,
      name: name,
    );
  }

  // Factory from JSON
  factory RoleModel.fromJson(Map<String, dynamic> json) {
    return RoleModel(
      id: json['id'] as String,
      name: json['name'] as String,
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}