import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../../core/widgets/custom_button.dart';
import '../../core/constants/app_constants.dart';

class RoleSelectionPage extends StatelessWidget {
  const RoleSelectionPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Кто вы?')),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const Spacer(),
            Image.network(
              'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=600&q=60',
              height: 180,
              fit: BoxFit.cover,
            ),
            const SizedBox(height: 24),
            CustomButton(
              label: 'Я исполнитель',
              onPressed: () => context.go('/register-executor'),
            ),
            const SizedBox(height: 12),
            CustomButton(
              label: 'Я заказчик',
              outlined: true,
              onPressed: () => context.go('/register-customer'),
            ),
            const Spacer(),
            TextButton(
              onPressed: () => context.go('/auth'),
              child: const Text('Уже есть аккаунт? Войти'),
            )
          ],
        ),
      ),
    );
  }
}

class ExecutorRegisterPage extends StatefulWidget {
  const ExecutorRegisterPage({super.key});

  @override
  State<ExecutorRegisterPage> createState() => _ExecutorRegisterPageState();
}

class _ExecutorRegisterPageState extends State<ExecutorRegisterPage> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final descriptionController = TextEditingController();
  final categories = ['Сантехник', 'Электрик', 'Маляр', 'Мебельщик', 'Ремонт техники'];
  final selected = <String>{};

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация исполнителя')),
      body: ListView(
        padding: const EdgeInsets.all(AppConstants.padding),
        children: [
          const Text('Фото лица (добавьте через камеру)', style: TextStyle(fontWeight: FontWeight.w600)),
          const SizedBox(height: 12),
          Container(
            height: 120,
            decoration: BoxDecoration(
              color: Colors.grey.shade200,
              borderRadius: BorderRadius.circular(14),
            ),
            child: const Center(child: Text('Фото')),
          ),
          const SizedBox(height: 16),
          TextField(controller: nameController, decoration: const InputDecoration(hintText: 'Имя')),
          const SizedBox(height: 12),
          TextField(controller: phoneController, decoration: const InputDecoration(hintText: 'Телефон'), keyboardType: TextInputType.phone),
          const SizedBox(height: 12),
          const Text('Категории'),
          Wrap(
            spacing: 8,
            children: categories
                .map((c) => FilterChip(
                      label: Text(c),
                      selected: selected.contains(c),
                      onSelected: (value) => setState(() {
                        if (value) {
                          selected.add(c);
                        } else {
                          selected.remove(c);
                        }
                      }),
                    ))
                .toList(),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: descriptionController,
            decoration: const InputDecoration(hintText: 'Короткое описание'),
            maxLines: 3,
          ),
          const SizedBox(height: 20),
          CustomButton(
            label: 'Продолжить',
            onPressed: () => context.go('/executor/home'),
          ),
        ],
      ),
    );
  }
}

class CustomerRegisterPage extends StatelessWidget {
  const CustomerRegisterPage({super.key});

  @override
  Widget build(BuildContext context) {
    final nameController = TextEditingController();
    final phoneController = TextEditingController();
    return Scaffold(
      appBar: AppBar(title: const Text('Регистрация заказчика')),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          children: [
            TextField(controller: nameController, decoration: const InputDecoration(hintText: 'Имя')), 
            const SizedBox(height: 12),
            TextField(controller: phoneController, decoration: const InputDecoration(hintText: 'Телефон'), keyboardType: TextInputType.phone),
            const Spacer(),
            CustomButton(label: 'Продолжить', onPressed: () => context.go('/customer/home')),
          ],
        ),
      ),
    );
  }
}
