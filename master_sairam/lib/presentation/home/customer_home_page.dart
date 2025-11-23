import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/custom_button.dart';
import '../orders/cubit/orders_cubit.dart';
import '../specialists/specialists_page.dart';
import '../widgets/app_card.dart';
import '../profile/profile_page.dart';

class CustomerHomePage extends StatefulWidget {
  const CustomerHomePage({super.key});

  @override
  State<CustomerHomePage> createState() => _CustomerHomePageState();
}

class _CustomerHomePageState extends State<CustomerHomePage> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    final pages = [
      _MyOrders(onCreate: () => context.go('/customer/create-order')),
      const SpecialistsPage(),
      const _ChatStub(),
      const _ProfileStub(),
    ];
    return Scaffold(
      appBar: AppBar(title: const Text('Заказчик')),
      body: pages[index],
      floatingActionButton: index == 0
          ? FloatingActionButton(
              onPressed: () => context.go('/customer/create-order'),
              backgroundColor: Theme.of(context).colorScheme.primary,
              child: const Icon(Icons.add, color: Colors.white),
            )
          : null,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: index,
        onTap: (value) => setState(() => index = value),
        selectedItemColor: Theme.of(context).colorScheme.primary,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home_outlined), label: 'Главная'),
          BottomNavigationBarItem(icon: Icon(Icons.engineering_outlined), label: 'Исполнители'),
          BottomNavigationBarItem(icon: Icon(Icons.chat_bubble_outline), label: 'Чаты'),
          BottomNavigationBarItem(icon: Icon(Icons.person_outline), label: 'Профиль'),
        ],
      ),
    );
  }
}

class _MyOrders extends StatelessWidget {
  final VoidCallback onCreate;
  const _MyOrders({required this.onCreate});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OrdersCubit, OrdersState>(
      builder: (context, state) {
        if (state is OrdersLoading) return const Center(child: CircularProgressIndicator());
        if (state is OrdersLoaded) {
          return ListView(
            padding: const EdgeInsets.all(AppConstants.padding),
            children: [
              CustomButton(label: 'Создать заказ', onPressed: onCreate),
              const SizedBox(height: 12),
              ...state.orders.map((o) => AppCard(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(o.title, style: const TextStyle(fontWeight: FontWeight.w700)),
                        const SizedBox(height: 6),
                        Text(Formatters.formatPrice(o.price)),
                        const SizedBox(height: 6),
                        Text(o.description),
                      ],
                    ),
                  )),
            ],
          );
        }
        return const SizedBox();
      },
    );
  }
}

class _ChatStub extends StatelessWidget {
  const _ChatStub();
  @override
  Widget build(BuildContext context) => const Center(child: Text('Чаты с исполнителями'));
}

class _ProfileStub extends StatelessWidget {
  const _ProfileStub();
  @override
  Widget build(BuildContext context) => const ProfilePage();
}
