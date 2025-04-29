import '../../domain/entities/auth_result.dart';
import 'user_model.dart';

class AuthModel {
  final UserModel? user;
  final String? token;
  final bool isAuthenticated;
  final String? errorMessage;

  AuthModel({
    this.user,
    this.token,
    required this.isAuthenticated,
    this.errorMessage,
  });

  // Convert to domain entity
  AuthResult toDomain() {
    return AuthResult(
      user: user?.toDomain(),
      token: token,
      isAuthenticated: isAuthenticated,
      errorMessage: errorMessage,
    );
  }

  factory AuthModel.authenticated(UserModel user, String token) {
    return AuthModel(
      user: user,
      token: token,
      isAuthenticated: true,
    );
  }

  factory AuthModel.unauthenticated({String? errorMessage}) {
    return AuthModel(
      isAuthenticated: false,
      errorMessage: errorMessage,
    );
  }
}