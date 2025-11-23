import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import 'cubit/auth_cubit.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  final controller = TextEditingController(text: '+7 ');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Вход по номеру')),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: BlocConsumer<AuthCubit, AuthState>(
          listener: (context, state) {
            if (state is AuthSuccess) {
              ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Добро пожаловать!')));
              context.go('/executor/home');
            }
          },
          builder: (context, state) {
            return Column(
              children: [
                TextField(
                  controller: controller,
                  keyboardType: TextInputType.phone,
                  decoration: const InputDecoration(hintText: 'Номер телефона'),
                ),
                const SizedBox(height: 20),
                if (state is AuthLoading) const CircularProgressIndicator(),
                if (state is AuthFailure) Text(state.message, style: const TextStyle(color: Colors.red)),
                const Spacer(),
                CustomButton(
                  label: 'Получить код',
                  onPressed: () => context.read<AuthCubit>().signIn(controller.text),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
