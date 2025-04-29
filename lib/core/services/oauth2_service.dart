import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/services.dart';
import 'package:flutter_appauth/flutter_appauth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'dart:math';
import 'package:crypto/crypto.dart';

import '../../features/auth/data/models/auth_model.dart';
import '../../features/auth/data/models/user_model.dart';
import '../api/api_client.dart';
import '../constants/api_constants.dart';
import '../constants/storage_constants.dart';

class OAuth2Service {
  final ApiClient _apiClient;
  final FlutterAppAuth _appAuth = FlutterAppAuth();
  final GoogleSignIn _googleSignIn;
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Konstanta untuk OAuth2
  static const String _clientId = 'YOUR_CLIENT_ID'; // Ganti dengan client ID Anda
  static String _redirectUrl = dotenv.env['REDIRECT_URL'] ?? 'com.example.flutter_simple://oauth2redirect';

  String get _googleClientId => dotenv.env['GOOGLE_CLIENT_ID'] ?? '';
  String get _googleAuthEndpoint => dotenv.env['GOOGLE_AUTH_ENDPOINT'] ?? 'https://accounts.google.com/o/oauth2/v2/auth';
  String get _googleTokenEndpoint => dotenv.env['GOOGLE_TOKEN_ENDPOINT'] ?? 'https://oauth2.googleapis.com/token';
  String get _googleRedirect => dotenv.env['GOOGLE_REDIRECT_URL'] ?? _redirectUrl;


  // Apple OAuth settings
  String get _appleClientId => dotenv.env['APPLE_CLIENT_ID'] ?? '';
  String get _appleRedirectUrl => dotenv.env['APPLE_REDIRECT_URL'] ?? 'com.example.flutter_simple://oauth2redirect';


  // Konstanta untuk Kemnaker OAuth

  String get _kemnakerClientId => dotenv.env['KEMNAKER_CLIENT_ID'] ?? '';
  String get _kemnakerAuthEndpoint => dotenv.env['KEMNAKER_AUTH_ENDPOINT'] ?? 'https://account.kemnaker.go.id/auth';
  String get _kemnakerTokenEndpoint => dotenv.env['KEMNAKER_TOKEN_ENDPOINT'] ?? 'https://account.kemnaker.go.id/api/v1';


  OAuth2Service({required ApiClient apiClient}) : _apiClient = apiClient,
        _googleSignIn = GoogleSignIn(
          clientId: "448652889990-937k4gtbd1cnfvqjgeij2qq8gdnuefop.apps.googleusercontent.com",
          scopes: [
            'email',
            'https://www.googleapis.com/auth/contacts.readonly',
          ]
        );

  // Login dengan Google
  Future<AuthModel> loginWithGoogle() async {
    try {
      print("Attempting Google Sign In with google_sign_in package");

      // Memulai proses sign in
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();

      if (googleUser == null) {
        // User membatalkan proses login
        return AuthModel.unauthenticated(
          errorMessage: 'Google sign in was cancelled by user',
        );
      }
      print("gogle user ${googleUser}");

      // Mendapatkan auth details dari request
      final GoogleSignInAuthentication googleAuth = await googleUser.authentication;

      // Mendapatkan token
      final String? accessToken = googleAuth.accessToken;
      final String? idToken = googleAuth.idToken;

      if (accessToken == null) {
        return AuthModel.unauthenticated(
          errorMessage: 'Failed to get Google access token',
        );
      }

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(StorageConstants.accessToken, accessToken);

      // Jika perlu, simpan idToken juga
      if (idToken != null) {
        await prefs.setString(StorageConstants.idToken, idToken);
      }

      final credential = GoogleAuthProvider.credential(
        accessToken: accessToken,
        idToken: idToken
      );
      final result = await _firebaseAuth.signInWithCredential(credential);
      print("result $result");

      return AuthModel.authenticated(
        UserModel(
          id: googleUser.id,
          username: googleUser.displayName ?? googleUser.email.split('@')[0],
          email: googleUser.email,
          firstName: googleUser.displayName?.split(' ').first ?? '',
          lastName: googleUser.displayName?.split(' ').skip(1).join(' ') ?? '',
          avatarUrl: googleUser.photoUrl!,
          createdAt: DateTime.now(),
          updatedAt: DateTime.now(),
        ),
        accessToken,
      );



      // return await _processAuthResult(result);
    } catch (e) {
      print("Google OAuth error: $e");
      if (e is PlatformException) {
        print('Error code: ${e.code}');
        print('Error message: ${e.message}');
        print('Error details: ${e.details}');
      }
      return AuthModel.unauthenticated(
        errorMessage: 'Google sign in failed: ${e.toString()}',
      );
    }
  }

  // Login dengan Apple
  Future<AuthModel> loginWithApple() async {
    try {
      // Konfigurasi untuk Apple Sign In
      final authorizationTokenRequest = AuthorizationTokenRequest(
        _appleClientId,
        _appleRedirectUrl,
        serviceConfiguration: const AuthorizationServiceConfiguration(
          authorizationEndpoint: 'https://appleid.apple.com/auth/authorize',
          tokenEndpoint: 'https://appleid.apple.com/auth/token',
        ),
        scopes: ['email', 'name'],
        additionalParameters: {
          'response_mode': 'form_post',
        },
      );

      // Lakukan request
      final result = await _appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );

      return await _processAuthResult(result);
    } catch (e) {
      print("Apple OAuth error: $e");
      return AuthModel.unauthenticated(
        errorMessage: 'Apple sign in failed: ${e.toString()}',
      );
    }
  }

  // Login dengan Microsoft
  Future<AuthModel> loginWithMicrosoft() async {
    try {
      // Konfigurasi untuk Microsoft OAuth
      final authorizationTokenRequest = AuthorizationTokenRequest(
        _clientId,
        _redirectUrl,
        serviceConfiguration: const AuthorizationServiceConfiguration(
          authorizationEndpoint: 'https://login.microsoftonline.com/common/oauth2/v2.0/authorize',
          tokenEndpoint: 'https://login.microsoftonline.com/common/oauth2/v2.0/token',
        ),
        scopes: ['openid', 'profile', 'email', 'offline_access'],
      );

      // Lakukan request
      final result = await _appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );

      return await _processAuthResult(result);
    } catch (e) {
      print("Microsoft OAuth error: $e");
      return AuthModel.unauthenticated(
        errorMessage: 'Microsoft sign in failed: ${e.toString()}',
      );
    }
  }

  // Login dengan Kemnaker
  Future<AuthModel> loginWithKemnaker() async {
    try {
      // Konfigurasi untuk Kemnaker OAuth
      final authorizationTokenRequest = AuthorizationTokenRequest(
        _kemnakerClientId,
        _redirectUrl,
        serviceConfiguration: AuthorizationServiceConfiguration(
          authorizationEndpoint: _kemnakerAuthEndpoint,
          tokenEndpoint: _kemnakerTokenEndpoint,
        ),
        scopes: ['basic', 'email'],
      );

      // Lakukan request
      final result = await _appAuth.authorizeAndExchangeCode(
        authorizationTokenRequest,
      );
      _prosesMetaUser(result, "kemnaker_access_token");

      return await _processAuthResult(result);
    } catch (e) {
      print("Kemnaker OAuth error: $e");
      return AuthModel.unauthenticated(
        errorMessage: 'Kemnaker sign in failed: ${e.toString()}',
      );
    }
  }

  // Helper method untuk memproses hasil autentikasi
  Future<AuthModel> _processAuthResult(TokenResponse? result) async {
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
  }

  // Refresh token
  Future<AuthModel> refreshToken(String refreshToken) async {
    try {
      final tokenRequest = TokenRequest(
        _clientId,
        _redirectUrl,
        refreshToken: refreshToken,
        grantType: 'refresh_token',
      );

      final result = await _appAuth.token(tokenRequest);

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

  Future<void> _prosesMetaUser(TokenResponse result, String provider) async{
    try {
      // Send Kemnaker token to your backend
      final userMetaresponse = await _apiClient.post(
        '/auth/metas',
        data: {
          'key': provider,
          'value': result.accessToken
        },
      );
      print(" Send Metas $userMetaresponse");

    } catch (e) {
      print('Error communicating with backend: $e');
    }
  }
  // Helper methods untuk PKCE (jika dibutuhkan untuk implementasi manual)
  String _generateRandomString(int length) {
    final random = Random.secure();
    final values = List<int>.generate(length, (i) => random.nextInt(256));
    return base64Url.encode(values).substring(0, length);
  }

  String _generateCodeChallenge(String codeVerifier) {
    final bytes = utf8.encode(codeVerifier);
    final digest = sha256.convert(bytes);
    return base64Url
        .encode(digest.bytes)
        .replaceAll('+', '-')
        .replaceAll('/', '_')
        .replaceAll('=', '');
  }
}