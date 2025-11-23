import '../entities/auth_response.dart';

abstract class AuthRepository {
  Future<AuthResponse> login(String phone);
}
