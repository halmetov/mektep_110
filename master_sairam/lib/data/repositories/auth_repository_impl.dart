import '../../domain/entities/auth_response.dart';
import '../../domain/repositories/auth_repository.dart';
import '../api/api_service.dart';

class AuthRepositoryImpl implements AuthRepository {
  final ApiService apiService;

  AuthRepositoryImpl(this.apiService);

  @override
  Future<AuthResponse> login(String phone) => apiService.login(phone);
}
