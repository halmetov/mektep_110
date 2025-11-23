import 'package:equatable/equatable.dart';

class AuthResponse extends Equatable {
  final String token;
  final String userName;

  const AuthResponse({required this.token, required this.userName});

  @override
  List<Object?> get props => [token, userName];
}
