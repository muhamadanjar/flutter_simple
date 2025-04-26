import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import '../api/api_client.dart';
import '../constants/api_constants.dart';
import '../constants/storage_constants.dart';
import '../../data/models/auth_model.dart';
import '../../data/models/user_model.dart';

class OAuth2Service {
  final ApiClient _apiClient;
  final FlutterAppAuth _appAuth = FlutterAppAuth();

  // Konstanta untuk OAuth2
  static const String _clientId = 'your_client_id';
  static const String _redirectUrl = 'com.example.flutter_simple://oauth2redirect';

  OAuth2Service({required ApiClient apiClient}) : _apiClient = apiClient;

  // Generate a random string for PKCE
  String _generateRandomString(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values).substring(0, length);
  }

  // Generate code challenge for PKCE
  String _generateCodeChallenge(String codeVerifier) {
    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    return base64Url
        .encode(digest.bytes)
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '');
  }

  // Login generic dengan AppAuth
  Future<AuthModel> loginWithProvider(String provider) async {
    try {
      // Generate code verifier for PKCE
      final codeVerifier = _generateRandomString(64);
      final codeChallenge = _generateCodeChallenge(codeVerifier);

      // Konfigurasi request
      final authorizationTokenRequest = AuthorizationTokenRequest(
        _clientId,
        _redirectUrl,
        issuer: ApiConstants.baseUrl, // Hapus jika tidak menggunakan OpenID Connect
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: '${ApiConstants.baseUrl}/oauth2/authorize',
          tokenEndpoint: '${ApiConstants.baseUrl}/oauth2/token',
        ),
        scopes: ['openid', 'profile', 'email'],
        promptValues: ['login'],
        additionalParameters: {'provider': provider},
        // codeVerifier: codeVerifier,
        // codeChallenge: codeChallenge,
        // codeChallengeMethod: 'S256',
      );

      // Lakukan request
      final result = await _appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );

      if (result != null && result.accessToken != null) {
        // Simpan token
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageConstants.accessToken, result.accessToken!);

        if (result.refreshToken != null) {
          await prefs.setString(StorageConstants.refreshToken, result.refreshToken!);
        }

        // Dapatkan informasi pengguna
        try {
          final userResponse = await _apiClient.get(ApiConstants.me);
          if (userResponse != null && userResponse['data'] != null) {
            final userData = userResponse['data']['user'];
            final userModel = UserModel.fromJson(userData);
            return AuthModel.authenticated(userModel, result.accessToken!);
          }
        } catch (e) {
          print('Error getting user info: $e');
        }

        // Jika tidak bisa mendapatkan info pengguna, masih return authenticated
        return AuthModel.authenticated(
          UserModel(
            id: 'unknown',
            username: 'unknown',
            email: 'unknown',
            firstName: '',
            lastName: '',
            createdAt: DateTime.now(),
            updatedAt: DateTime.now(),
          ),
          result.accessToken!,
        );
      }

      return AuthModel.unauthenticated(
        errorMessage: 'Failed to get access token',
      );
    } catch (e) {
      return AuthModel.unauthenticated(
        errorMessage: 'OAuth2 login failed: ${e.toString()}',
      );
    }
  }

  // Spesifik untuk provider
  Future<AuthModel> loginWithGoogle() async {
    return await loginWithProvider('google');
  }

  Future<AuthModel> loginWithMicrosoft() async {
    return await loginWithProvider('microsoft');
  }

  Future<AuthModel> loginWithApple() async {
    return await loginWithProvider('apple');
  }

  // Refresh token
  Future<AuthModel> refreshToken(String refreshToken) async {
    try {
      final TokenRequest tokenRequest = TokenRequest(
        _clientId,
        _redirectUrl,
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: '${ApiConstants.baseUrl}/oauth2/authorize',
          tokenEndpoint: '${ApiConstants.baseUrl}/oauth2/token',
        ),
        refreshToken: refreshToken,
        grantType: 'refresh_token',
      );

      final TokenResponse? result = await _appAuth.token(tokenRequest);

      if (result != null && result.accessToken != null) {
        // Simpan token baru
        final prefs = await SharedPreferences.getInstance();
        await prefs.setString(StorageConstants.accessToken, result.accessToken!);

        if (result.refreshToken != null) {
          await prefs.setString(StorageConstants.refreshToken, result.refreshToken!);
        }

        // Dapatkan informasi pengguna
        final userResponse = await _apiClient.get(ApiConstants.me);
        if (userResponse != null && userResponse['data'] != null) {
          final userData = userResponse['data']['user'];
          final userModel = UserModel.fromJson(userData);
          return AuthModel.authenticated(userModel, result.accessToken!);
        }

        return AuthModel.unauthenticated(
          errorMessage: 'Failed to get user information after token refresh',
        );
      } else {
        return AuthModel.unauthenticated(
          errorMessage: 'Token refresh failed: No token response',
        );
      }
    } catch (e) {
      return AuthModel.unauthenticated(
        errorMessage: 'Token refresh failed: ${e.toString()}',
      );
    }
  }
}