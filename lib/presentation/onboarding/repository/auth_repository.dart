import 'package:flutter_assesment/presentation/onboarding/model/user_model.dart';
import 'package:flutter_assesment/services/api_client.dart';

class AuthRepository {
  final ApiClient apiClient;

  AuthRepository(this.apiClient);

  Future<UserModel> login(String username, String password) async {
    final response = await apiClient.post('/login', {
      'username': username,
      'password': password,
    });
    if (response['status']) {
      return UserModel.fromJson(response['data']);
    } else {
      throw Exception('Login failed');
    }
  }
}
