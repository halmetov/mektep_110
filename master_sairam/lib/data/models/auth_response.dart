import '../../domain/entities/auth_response.dart';

class AuthResponseModel extends AuthResponse {
  const AuthResponseModel({required super.token, required super.userName});

  factory AuthResponseModel.fromJson(Map<String, dynamic> json) => AuthResponseModel(
        token: json['token'] as String,
        userName: json['userName'] as String,
      );
}
