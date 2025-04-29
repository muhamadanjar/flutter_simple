import 'package:equatable/equatable.dart';
import 'package:flutter_simple/features/auth/domain/entities/role.dart';

class User extends Equatable {
  final String id;
  final String username;
  final String email;
  final String firstName;
  final String lastName;
  final String name;
  final bool isActive;
  final bool isSuperuser;
  final List<Role> roles;
  final String avatarUrl;
  // final DateTime createdAt;
  // final DateTime updatedAt;

  const User({
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
    // required this.createdAt,
    // required this.updatedAt,
  });

  // Method untuk keperluan authorization
  bool hasRole(String requiredRole) {
    return roles.any((role) => role.name == requiredRole);
  }

  @override
  List<Object?> get props => [
    id,
    username,
    email,
    firstName,
    lastName,
    name,
    isActive,
    isSuperuser,
    roles,
    avatarUrl,
    // createdAt,
    // updatedAt
  ];
}