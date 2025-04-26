// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserModel _$UserModelFromJson(Map<String, dynamic> json) => UserModel(
  id: json['id'] as String,
  username: json['username'] as String,
  email: json['email'] as String,
  firstName: json['first_name'] as String,
  lastName: json['last_name'] as String,
  name: json['name'] as String? ?? '',
  isActive: json['is_active'] as bool? ?? true,
  isSuperuser: json['is_superuser'] as bool? ?? false,
  roles:
      (json['roles'] as List<dynamic>?)
          ?.map((e) => RoleModel.fromJson(e as Map<String, dynamic>))
          .toList() ??
      const [],
  avatarUrl: json['avatar_url'] as String? ?? '',
  createdAt: UserModel._dateTimeFromJson(json['created_at']),
  updatedAt: UserModel._dateTimeFromJson(json['updated_at']),
);

Map<String, dynamic> _$UserModelToJson(UserModel instance) => <String, dynamic>{
  'id': instance.id,
  'username': instance.username,
  'email': instance.email,
  'first_name': instance.firstName,
  'last_name': instance.lastName,
  'name': instance.name,
  'is_active': instance.isActive,
  'is_superuser': instance.isSuperuser,
  'roles': instance.roles,
  'avatar_url': instance.avatarUrl,
  'created_at': UserModel._dateTimeToJson(instance.createdAt),
  'updated_at': UserModel._dateTimeToJson(instance.updatedAt),
};
