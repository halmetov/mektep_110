import '../entities/auth_response.dart';
import '../repositories/auth_repository.dart';

class Login {
  final AuthRepository repository;

  Login(this.repository);

  Future<AuthResponse> call(String phone) => repository.login(phone);
}
