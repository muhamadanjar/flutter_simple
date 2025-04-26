import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../constants/storage_constants.dart';

class TokenInterceptor extends Interceptor {
  @override
  Future<void> onRequest(
      RequestOptions options,
      RequestInterceptorHandler handler,
      ) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(StorageConstants.accessToken);

    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }

    return handler.next(options);
  }

  @override
  Future<void> onError(
      DioException err,
      ErrorInterceptorHandler handler,
      ) async {
    // Handle 401 errors (token expired)
    if (err.response?.statusCode == 401) {
      // Try to refresh token
      final refreshed = await _refreshToken();

      if (refreshed) {
        // Retry the request with new token
        final prefs = await SharedPreferences.getInstance();
        final newToken = prefs.getString(StorageConstants.accessToken);

        if (newToken != null) {
          // Clone the original request
          final options = err.requestOptions;
          options.headers['Authorization'] = 'Bearer $newToken';

          // Create new request with the updated token
          final dio = Dio();
          final response = await dio.fetch(options);
          return handler.resolve(response);
        }
      }

      // If refresh token fails, handle the error normally
    }

    return handler.next(err);
  }

  // Method to refresh token
  Future<bool> _refreshToken() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final refreshToken = prefs.getString(StorageConstants.refreshToken);

      if (refreshToken == null || refreshToken.isEmpty) {
        return false;
      }

      // Create a new Dio instance to avoid interceptor loop
      final dio = Dio();

      final response = await dio.post(
        'https://your-api.com/api/auth/refresh',
        data: {'refresh_token': refreshToken},
      );

      if (response.statusCode == 200 && response.data['token'] != null) {
        // Save new tokens
        await prefs.setString(
          StorageConstants.accessToken,
          response.data['token'],
        );

        if (response.data['refresh_token'] != null) {
          await prefs.setString(
            StorageConstants.refreshToken,
            response.data['refresh_token'],
          );
        }

        return true;
      }

      return false;
    } catch (e) {
      // Handle refresh token failure
      print('Failed to refresh token: $e');

      // Clear tokens on refresh failure
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(StorageConstants.accessToken);
      await prefs.remove(StorageConstants.refreshToken);

      return false;
    }
  }
}
