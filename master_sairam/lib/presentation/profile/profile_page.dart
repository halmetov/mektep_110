import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import '../subscriptions/subscription_sheet.dart';
import '../subscriptions/cubit/subscription_cubit.dart';

class ProfilePage extends StatelessWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context) {
    final hasAccess = context.watch<SubscriptionCubit>().state.hasAccess;
    return Scaffold(
      appBar: AppBar(title: const Text('Профиль')),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          children: [
            Row(
              children: [
                const CircleAvatar(radius: 32, backgroundImage: NetworkImage('https://via.placeholder.com/120')),
                const SizedBox(width: 12),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: const [Text('Иван Петров', style: TextStyle(fontWeight: FontWeight.w700)), Text('Баланс: 12 000 ₸')]),
              ],
            ),
            const SizedBox(height: 16),
            _ProfileTile(title: 'Мои отклики', icon: Icons.message_outlined),
            _ProfileTile(title: 'Мои заказы', icon: Icons.receipt_long),
            _ProfileTile(title: 'Изменить данные', icon: Icons.edit_outlined),
            _ProfileTile(title: 'Выход', icon: Icons.logout),
            const SizedBox(height: 20),
            CustomButton(
              label: hasAccess ? 'Тариф активен' : 'Купить тариф',
              onPressed: hasAccess
                  ? null
                  : () => showModalBottomSheet(
                        context: context,
                        shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                        builder: (_) => const SubscriptionSheet(),
                      ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileTile extends StatelessWidget {
  final String title;
  final IconData icon;
  const _ProfileTile({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {},
    );
  }
}
