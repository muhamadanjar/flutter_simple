import 'package:equatable/equatable.dart';
import 'user.dart';

class AuthResult extends Equatable {
  final User? user;
  final String? token;
  final bool isAuthenticated;
  final String? errorMessage;

  const AuthResult({
    this.user,
    this.token,
    required this.isAuthenticated,
    this.errorMessage,
  });

  factory AuthResult.authenticated(User user, String token) {
    return AuthResult(
      user: user,
      token: token,
      isAuthenticated: true,
    );
  }

  factory AuthResult.unauthenticated({String? errorMessage}) {
    return AuthResult(
      isAuthenticated: false,
      errorMessage: errorMessage,
    );
  }

  @override
  List<Object?> get props => [user, token, isAuthenticated, errorMessage];
}