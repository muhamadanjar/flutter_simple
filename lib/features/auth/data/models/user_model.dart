import 'package:flutter_simple/features/auth/data/models/role_model.dart';
import 'package:flutter_simple/features/auth/domain/entities/user.dart';
import 'package:json_annotation/json_annotation.dart';

part 'user_model.g.dart';

@JsonSerializable()
class UserModel {
  final String id;
  final String username;
  final String email;
  @JsonKey(name: 'first_name')
  final String firstName;
  @JsonKey(name: 'last_name')
  final String lastName;
  final String name;
  @JsonKey(name: 'is_active')
  final bool isActive;
  @JsonKey(name: 'is_superuser')
  final bool isSuperuser;
  final List<RoleModel> roles;
  @JsonKey(name: 'avatar_url')
  final String avatarUrl;
  @JsonKey(name: 'created_at', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime createdAt;
  @JsonKey(name: 'updated_at', fromJson: _dateTimeFromJson, toJson: _dateTimeToJson)
  final DateTime updatedAt;

  UserModel({
    required this.id,
    required this.username,
    required this.email,
    required this.firstName,
    required this.lastName,
    this.name = '',
    this.isActive = true,
    this.isSuperuser = false,
    this.roles = const [],
    this.avatarUrl = '',
    required this.createdAt,
    required this.updatedAt,
  });

  // Convert to domain entity
  User toDomain() {
    return User(
      id: id,
      username: username,
      email: email,
      firstName: firstName,
      lastName: lastName,
      name: name,
      isActive: isActive,
      isSuperuser: isSuperuser,
      roles: roles.map((role) => role.toDomain()).toList(),
      avatarUrl: avatarUrl,
      // createdAt: createdAt,
      // updatedAt: updatedAt,
    );
  }

  // Factory from JSON
  factory UserModel.fromJson(Map<String, dynamic> json) {
    return UserModel(
      id: json['id'] as String,
      username: json['username'] as String,
      email: json['email'] as String,
      firstName: json['first_name'] as String,
      lastName: json['last_name'] as String,
      name: json['name'] as String? ?? '',
      isActive: json['is_active'] as bool? ?? true,
      isSuperuser: json['is_superuser'] as bool? ?? false,
      roles: (json['roles'] as List<dynamic>?)
          ?.map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
          .toList() ?? [],
      avatarUrl: json['avatar_url'] as String? ?? '',
      createdAt: _dateTimeFromJson(json['created_at']),
      updatedAt: _dateTimeFromJson(json['updated_at']),
    );
  }

  // Convert to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'username': username,
      'email': email,
      'first_name': firstName,
      'last_name': lastName,
      'name': name,
      'is_active': isActive,
      'is_superuser': isSuperuser,
      'roles': roles.map((role) => role.toJson()).toList(),
      'avatar_url': avatarUrl,
      // 'created_at': _dateTimeToJson(createdAt),
      // 'updated_at': _dateTimeToJson(updatedAt),
    };
  }

  // JSON converters for DateTime
  static DateTime _dateTimeFromJson(dynamic json) {
    if (json is String) {
      return DateTime.parse(json);
    }
    // Default value if date can't be parsed
    return DateTime.now();
  }

  static String _dateTimeToJson(DateTime dateTime) {
    return dateTime.toIso8601String();
  }
}
