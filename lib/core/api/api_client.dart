import 'package:dio/dio.dart';
import '../constants/api_constants.dart';
import '../errors/failure.dart';
import 'token_interceptor.dart';

class ApiClient {
  late Dio _dio;

  Dio _withBaseUrl(String? baseUrl) {
    if (baseUrl == null || baseUrl == _dio.options.baseUrl) {
      return _dio;
    }

    final dio = Dio(
      _dio.options.copyWith(baseUrl: baseUrl),
    );

    dio.interceptors.addAll(_dio.interceptors);

    return dio;
  }

  ApiClient() {
    _dio = Dio(
      BaseOptions(
        baseUrl: ApiConstants.baseUrl,
        connectTimeout: const Duration(milliseconds: 15000),
        receiveTimeout: const Duration(milliseconds: 15000),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );

    // Tambahkan interceptor untuk token auth
    _dio.interceptors.add(TokenInterceptor());

    // Tambahkan logging interceptor
    _dio.interceptors.add(LogInterceptor(
      requestBody: true,
      responseBody: true,
    ));
  }

  // GET request
  Future<dynamic> get(String path, {Map<String, dynamic>? queryParameters, String? baseUrl,}) async {
    try {
      final response = await _withBaseUrl(baseUrl).get(
        path,
        queryParameters: queryParameters,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  // POST request
  Future<dynamic> post(String path, {dynamic data}) async {
    try {
      final response = await _dio.post(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  // PUT request
  Future<dynamic> put(String path, {dynamic data}) async {
    try {
      final response = await _dio.put(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  // DELETE request
  Future<dynamic> delete(String path, {dynamic data}) async {
    try {
      final response = await _dio.delete(
        path,
        data: data,
      );
      return response.data;
    } on DioException catch (e) {
      throw _handleError(e);
    } catch (e) {
      throw ServerFailure(message: e.toString());
    }
  }

  // Handle Dio errors
  Failure _handleError(DioException error) {
    if (error.type == DioExceptionType.connectionTimeout ||
        error.type == DioExceptionType.receiveTimeout ||
        error.type == DioExceptionType.sendTimeout) {
      return const ServerFailure(
        message: 'Connection timeout. Please check your internet connection.',
      );
    } else if (error.type == DioExceptionType.connectionError) {
      return const ServerFailure(
        message: 'No internet connection. Please check your network.',
      );
    } else {
      // Handle API error responses
      if (error.response != null) {
        final statusCode = error.response!.statusCode;
        final data = error.response!.data;

        if (statusCode == 401) {
          return AuthFailure(
            message: data['message'] ?? 'Unauthorized: Please login again.',
            code: statusCode,
          );
        } else if (statusCode == 403) {
          return AuthFailure(
            message: data['message'] ?? 'Forbidden: Access denied.',
            code: statusCode,
          );
        } else if (statusCode == 404) {
          return ServerFailure(
            message: data['message'] ?? 'Resource not found.',
            code: statusCode,
          );
        } else if (statusCode == 422) {
          // Validation errors
          String validationMessage = 'Validation Error';
          if (data is Map && data['errors'] != null) {
            // Combine all validation messages
            final errors = data['errors'] as Map;
            validationMessage = errors.values
                .map((e) => e is List ? e.join(', ') : e.toString())
                .join(', ');
          }
          return ServerFailure(
            message: validationMessage,
            code: statusCode,
          );
        } else {
          return ServerFailure(
            message: data['message'] ?? 'Server error occurred.',
            code: statusCode,
          );
        }
      } else {
        return ServerFailure(
          message: error.message ?? 'Unknown error occurred.',
        );
      }
    }
  }
}
