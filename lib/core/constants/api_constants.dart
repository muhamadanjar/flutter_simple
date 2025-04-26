class ApiConstants {
  static const String baseUrl = 'http://192.168.1.8:8080';

  // Auth endpoints
  static const String login = '/auth/login';
  static const String register = '/auth/register';
  static const String logout = '/auth/logout';
  static const String refreshToken = '/auth/refresh';
  static const String me = '/auth/info';

  // User endpoints
  static const String users = '/users';
  static const String userById = '/users/{id}';
  static const String updateUser = '/users/{id}';
  static const String updateUserRole = '/users/{id}/role';

  static const String authorizeEndpoint = '/oauth2/authorize';
  static const String tokenEndpoint = '/oauth2/token';
}