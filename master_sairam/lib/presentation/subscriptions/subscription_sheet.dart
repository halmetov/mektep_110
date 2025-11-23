import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import 'cubit/subscription_cubit.dart';

class SubscriptionSheet extends StatelessWidget {
  const SubscriptionSheet({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Тарифы исполнителя', style: TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
          const SizedBox(height: 12),
          AppPlanCard(
            title: '3 отклика',
            description: 'Разблокируйте данные и откликайтесь на 3 заказа',
            price: '1 990 ₸',
            onPressed: () {
              context.read<SubscriptionCubit>().buyResponses();
              Navigator.of(context).pop();
            },
          ),
          AppPlanCard(
            title: 'Тариф на месяц',
            description: 'Безлимитные отклики и контакты заказчиков',
            price: '5 990 ₸',
            onPressed: () {
              context.read<SubscriptionCubit>().buyMonthly();
              Navigator.of(context).pop();
            },
          ),
        ],
      ),
    );
  }
}

class AppPlanCard extends StatelessWidget {
  final String title;
  final String description;
  final String price;
  final VoidCallback onPressed;
  const AppPlanCard({super.key, required this.title, required this.description, required this.price, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title, style: const TextStyle(fontWeight: FontWeight.w700)),
            const SizedBox(height: 4),
            Text(description),
            const SizedBox(height: 8),
            Row(
              children: [
                Text(price, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
                const Spacer(),
                CustomButton(label: 'Купить', onPressed: onPressed),
              ],
            )
          ],
        ),
      ),
    );
  }
}
