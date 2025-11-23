import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/custom_button.dart';
import '../../domain/entities/order.dart';
import '../orders/cubit/orders_cubit.dart';
import '../subscriptions/cubit/subscription_cubit.dart';
import '../subscriptions/subscription_sheet.dart';
import '../widgets/app_card.dart';

class ExecutorHomePage extends StatefulWidget {
  const ExecutorHomePage({super.key});

  @override
  State<ExecutorHomePage> createState() => _ExecutorHomePageState();
}

class _ExecutorHomePageState extends State<ExecutorHomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      const _OrdersFeed(title: 'Рекомендации'),
      const _OrdersFeed(title: 'Все заказы'),
      const _ExecutorChatStub(),
      const _ExecutorProfileStub(),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Исполнитель')),
      body: pages[index],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() => index = value),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.recommend), label: 'Реком.'),
          BottomNavigationBarItem(icon: Icon(Icons.list_alt), label: 'Заказы'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Чаты'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Профиль'),
        ],
      ),
    );
  }
}

class _OrdersFeed extends StatelessWidget {
  final String title;
  const _OrdersFeed({required this.title});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        if (state is OrdersLoaded) {
          return ListView(
            padding: const EdgeInsets.all(AppConstants.padding),
            children: state.orders.map((e) => _OrderCard(order: e)).toList(),
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}

class _OrderCard extends StatelessWidget {
  final Order order;
  const _OrderCard({required this.order});

  @override
  Widget build(BuildContext context) {
    final hasAccess = context.watch<SubscriptionCubit>().state.hasAccess || order.isPremium;
    return AppCard(
      onTap: () => context.go('/executor/order/${order.id}'),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(order.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 16)),
              Text(Formatters.formatPrice(order.price), style: const TextStyle(fontWeight: FontWeight.bold)),
            ],
          ),
          const SizedBox(height: 6),
          Text(order.category, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 6),
          Text('Дата: ${Formatters.formatDate(order.date)}'),
          const SizedBox(height: 4),
          Text('Город: ${order.city}${hasAccess && order.street != null ? ', ${order.street}' : ''}'),
          const SizedBox(height: 8),
          Text(order.description),
          if (order.imageUrl != null)
            Padding(
              padding: const EdgeInsets.only(top: 8.0),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppConstants.cardRadius),
                child: Image.network(order.imageUrl!, height: 140, width: double.infinity, fit: BoxFit.cover),
              ),
            ),
          const SizedBox(height: 12),
          if (!hasAccess)
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: Colors.orange.shade50,
                borderRadius: BorderRadius.circular(12),
              ),
              child: const Text('Купите тариф чтобы открыть данные'),
            ),
          const SizedBox(height: 8),
          CustomButton(
            label: hasAccess ? 'Откликнуться' : 'Купить доступ',
            onPressed: () {
              if (hasAccess) {
                ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Отклик отправлен')));
              } else {
                showModalBottomSheet(
                  context: context,
                  shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(20))),
                  builder: (_) => const SubscriptionSheet(),
                );
              }
            },
          ),
        ],
      ),
    );
  }
}

class _ExecutorChatStub extends StatelessWidget {
  const _ExecutorChatStub();

  @override
  Widget build(BuildContext context) => const Center(child: Text('Ваши чаты и диалоги.'));
}

class _ExecutorProfileStub extends StatelessWidget {
  const _ExecutorProfileStub();

  @override
  Widget build(BuildContext context) => const ProfilePage();
}
