import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/auth_response.dart';
import '../../../domain/usecases/login.dart';

part 'auth_state.dart';

class AuthCubit extends Cubit<AuthState> {
  final Login login;

  AuthCubit(this.login) : super(AuthInitial());

  Future<void> signIn(String phone) async {
    emit(AuthLoading());
    try {
      final response = await login(phone);
      emit(AuthSuccess(response));
    } catch (e) {
      emit(AuthFailure(e.toString()));
    }
  }
}
