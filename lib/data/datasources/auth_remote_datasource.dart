// lib/data/datasources/auth_remote_datasource.dart
import 'dart:async';
import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../core/api/api_client.dart';
import '../../core/constants/api_constants.dart';
import '../../core/constants/storage_constants.dart';
import '../../core/errors/failure.dart';
import '../../core/services/oauth2_service.dart';
import '../models/auth_model.dart';
import '../models/user_model.dart';

abstract class AuthRemoteDataSource {
  Stream<AuthModel> get authStateChanges;
  Future<UserModel?> getCurrentUser();
  Future<AuthModel> signInWithEmailAndPassword(String username, String password);
  Future<AuthModel> signUpWithEmailAndPassword(
      String email,
      String password,
      String? displayName
      );
  Future<AuthModel> signInWithGoogle();
  Future<AuthModel> signInWithMicrosoft();
  Future<AuthModel> signInWithApple();
  Future<void> signOut();
  Future<void> resetPassword(String email);
}

class AuthRemoteDataSourceImpl implements AuthRemoteDataSource {
  final ApiClient _apiClient;
  final OAuth2Service _oauth2Service;
  final _authStateController = StreamController<AuthModel>.broadcast();

  AuthRemoteDataSourceImpl({
    required ApiClient apiClient,
    required OAuth2Service oauth2Service,
  }) : _apiClient = apiClient, _oauth2Service = oauth2Service {
    // Initialize auth state
    _checkAuthState();
  }

  Future<void> _checkAuthState() async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString(StorageConstants.accessToken);

      if (token != null && token.isNotEmpty) {
        // Try to get current user
        final user = await getCurrentUser();
        if (user != null) {
          _authStateController.add(AuthModel.authenticated(user, token));
          return;
        }
      }

      // If no token or user fetch fails
      _authStateController.add(AuthModel.unauthenticated());
    } catch (e) {
      _authStateController.add(
        AuthModel.unauthenticated(
          errorMessage: 'Failed to check auth state: ${e.toString()}',
        ),
      );
    }
  }

  @override
  Stream<AuthModel> get authStateChanges => _authStateController.stream;

  @override
  Future<UserModel?> getCurrentUser() async {
    try {
      final response = await _apiClient.get(ApiConstants.me);

      if (response != null && response['data'] != null) {
        final userData = response['data'];
        return UserModel.fromJson(userData);
      }

      return null;
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(
        message: 'Failed to get current user: ${e.toString()}',
      );
    }
  }

  @override
  Future<AuthModel> signInWithEmailAndPassword(
      String username,
      String password
      ) async {
    try {
      final response = await _apiClient.post(
        ApiConstants.login,
        data: {
          'username': username,
          'password': password,
        },
      );

      print("Raw API response: $response");

      if (response != null && response['data'] != null) {
        final respData = response['data'];
        print("Response data: ${response['data']['auth']}");

        print(" res : + ${respData}");
        // Akses token dari struktur bersarang
        final token = respData['auth']['access_token'];
        // Refresh token (jika ada)
        final refreshToken = respData['auth']['refresh_token'];
        // Data user
        final userData = respData['user'];

        print("Auth data: ${respData['auth']}");
        print("User data: ${respData['user']}");

        // Save tokens to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageConstants.accessToken, token);

        if (refreshToken != null) {
          await prefs.setString(StorageConstants.refreshToken, refreshToken);
        }

        final userModel = UserModel.fromJson(userData);

        // Update auth state
        final authModel = AuthModel.authenticated(userModel, token);
        _authStateController.add(authModel);

        return authModel;
      }

      return AuthModel.unauthenticated(
        errorMessage: 'Login failed: Invalid response format',
      );
    } on Failure catch (failure) {
      return AuthModel.unauthenticated(
        errorMessage: failure.message,
      );
    } catch (e) {
      return AuthModel.unauthenticated(
        errorMessage: 'Login failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<AuthModel> signUpWithEmailAndPassword(
      String email,
      String password,
      String? displayName
      ) async {
    try {
      final data = {
        'email': email,
        'password': password,
        'password_confirmation': password,
      };

      if (displayName != null && displayName.isNotEmpty) {
        data['name'] = displayName;
      }

      final response = await _apiClient.post(
        ApiConstants.register,
        data: data,
      );

      if (response != null &&
          response['token'] != null &&
          response['user'] != null) {

        final token = response['token'];
        final refreshToken = response['refresh_token'];
        final userData = response['user'];

        // Save tokens to shared preferences
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageConstants.accessToken, token);

        if (refreshToken != null) {
          await prefs.setString(StorageConstants.refreshToken, refreshToken);
        }

        final userModel = UserModel.fromJson(userData);

        // Update auth state
        final authModel = AuthModel.authenticated(userModel, token);
        _authStateController.add(authModel);

        return authModel;
      }

      return AuthModel.unauthenticated(
        errorMessage: 'Registration failed: Invalid response format',
      );
    } on Failure catch (failure) {
      return AuthModel.unauthenticated(
        errorMessage: failure.message,
      );
    } catch (e) {
      return AuthModel.unauthenticated(
        errorMessage: 'Registration failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<AuthModel> signInWithGoogle() async {
    try {
      print(">>> signInWithGoogle started");
      final authModel = await _oauth2Service.loginWithGoogle();

      if (authModel.isAuthenticated) {
        // Update auth state
        _authStateController.add(authModel);
        print("<<< signInWithGoogle completed successfully");
      } else {
        print("<<< signInWithGoogle failed: ${authModel.errorMessage}");
      }

      return authModel;
    } catch (e) {
      print("<<< signInWithGoogle failed with error: ${e.toString()}");
      return AuthModel.unauthenticated(
        errorMessage: 'Google sign in failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<AuthModel> signInWithMicrosoft() async {
    try {
      print(">>> signInWithMicrosoft started");
      final authModel = await _oauth2Service.loginWithMicrosoft();

      if (authModel.isAuthenticated) {
        // Update auth state
        _authStateController.add(authModel);
        print("<<< signInWithMicrosoft completed successfully");
      } else {
        print("<<< signInWithMicrosoft failed: ${authModel.errorMessage}");
      }

      return authModel;
    } catch (e) {
      print("<<< signInWithMicrosoft failed with error: ${e.toString()}");
      return AuthModel.unauthenticated(
        errorMessage: 'Microsoft sign in failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<AuthModel> signInWithApple() async {
    try {
      print(">>> signInWithApple started");
      final authModel = await _oauth2Service.loginWithApple();

      if (authModel.isAuthenticated) {
        // Update auth state
        _authStateController.add(authModel);
        print("<<< signInWithApple completed successfully");
      } else {
        print("<<< signInWithApple failed: ${authModel.errorMessage}");
      }

      return authModel;
    } catch (e) {
      print("<<< signInWithApple failed with error: ${e.toString()}");
      return AuthModel.unauthenticated(
        errorMessage: 'Apple sign in failed: ${e.toString()}',
      );
    }
  }

  @override
  Future<void> signOut() async {
    try {
      // Call logout API endpoint
      await _apiClient.post(ApiConstants.logout);
    } catch (e) {
      // Ignore error on logout API call
      print('Logout API error: ${e.toString()}');
    } finally {
      // Clear stored tokens
      final prefs = await SharedPreferences.getInstance();
      await prefs.remove(StorageConstants.accessToken);
      await prefs.remove(StorageConstants.refreshToken);

      // Update auth state
      _authStateController.add(AuthModel.unauthenticated());
    }
  }

  @override
  Future<void> resetPassword(String email) async {
    try {
      await _apiClient.post(
        '/auth/forgot-password',
        data: {'email': email},
      );
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(
        message: 'Password reset failed: ${e.toString()}',
      );
    }
  }
}