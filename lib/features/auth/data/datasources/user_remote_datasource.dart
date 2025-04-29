import '../../../../core/api/api_client.dart';
import '../../../../core/constants/api_constants.dart';
import '../../../../core/errors/failure.dart';
import '../models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<UserModel> getUserById(String userId);
  Future<UserModel> updateUserInfo({
    required String userId,
    String? displayName,
    String? photoUrl,
  });
  Future<UserModel> updateUserRole({
    required String userId,
    required String role,
  });
  Future<bool> hasRole(String userId, String role);
}

class UserRemoteDataSourceImpl implements UserRemoteDataSource {
  final ApiClient _apiClient;

  UserRemoteDataSourceImpl({required ApiClient apiClient})
      : _apiClient = apiClient;

  @override
  Future<UserModel> getUserById(String userId) async {
    try {
      final endpoint = ApiConstants.userById.replaceAll('{id}', userId);
      final response = await _apiClient.get(endpoint);

      if (response != null && response['user'] != null) {
        return UserModel.fromJson(response['user']);
      }

      throw ServerFailure(
        message: 'User not found',
      );
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(
        message: 'Failed to get user: ${e.toString()}',
      );
    }
  }

  @override
  Future<UserModel> updateUserInfo({
    required String userId,
    String? displayName,
    String? photoUrl,
  }) async {
    try {
      final endpoint = ApiConstants.updateUser.replaceAll('{id}', userId);

      final updateData = <String, dynamic>{};

      if (displayName != null) {
        updateData['name'] = displayName;
      }

      if (photoUrl != null) {
        updateData['photo_url'] = photoUrl;
      }

      if (updateData.isEmpty) {
        // Nothing to update, just return current user
        return await getUserById(userId);
      }

      final response = await _apiClient.put(
        endpoint,
        data: updateData,
      );

      if (response != null && response['user'] != null) {
        return UserModel.fromJson(response['user']);
      }

      throw ServerFailure(
        message: 'Failed to update user info: Invalid response',
      );
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(
        message: 'Failed to update user info: ${e.toString()}',
      );
    }
  }

  @override
  Future<UserModel> updateUserRole({
    required String userId,
    required String role,
  }) async {
    try {
      final endpoint = ApiConstants.updateUserRole.replaceAll('{id}', userId);

      final response = await _apiClient.put(
        endpoint,
        data: {'role': role},
      );

      if (response != null && response['user'] != null) {
        return UserModel.fromJson(response['user']);
      }

      throw ServerFailure(
        message: 'Failed to update user role: Invalid response',
      );
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(
        message: 'Failed to update user role: ${e.toString()}',
      );
    }
  }

  @override
  Future<bool> hasRole(String userId, String role) async {
    try {
      final user = await getUserById(userId);
      return user.roles.any((role) => role.name == role);
    } on Failure {
      rethrow;
    } catch (e) {
      throw ServerFailure(
        message: 'Failed to check user role: ${e.toString()}',
      );
    }
  }
}