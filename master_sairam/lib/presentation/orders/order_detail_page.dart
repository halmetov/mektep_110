import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/utils/formatters.dart';
import '../../core/widgets/custom_button.dart';
import '../../domain/entities/order.dart';
import 'cubit/orders_cubit.dart';

class OrderDetailPage extends StatefulWidget {
  final int orderId;
  final bool isExecutor;
  const OrderDetailPage({super.key, required this.orderId, required this.isExecutor});

  @override
  State<OrderDetailPage> createState() => _OrderDetailPageState();
}

class _OrderDetailPageState extends State<OrderDetailPage> {
  @override
  void initState() {
    super.initState();
    context.read<OrdersCubit>().loadOrder(widget.orderId);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Детали заказа')),
      body: BlocBuilder<OrdersCubit, OrdersState>(
        builder: (context, state) {
          if (state is OrdersLoading) return const Center(child: CircularProgressIndicator());
          if (state is OrderDetailLoaded) return _Body(order: state.order, isExecutor: widget.isExecutor);
          return const SizedBox();
        },
      ),
    );
  }
}

class _Body extends StatelessWidget {
  final Order order;
  final bool isExecutor;
  const _Body({required this.order, required this.isExecutor});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(AppConstants.padding),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(order.title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 20)),
          const SizedBox(height: 6),
          Text(order.category, style: const TextStyle(color: Colors.grey)),
          const SizedBox(height: 12),
          Text('Цена: ${Formatters.formatPrice(order.price)}'),
          Text('Дата: ${Formatters.formatDate(order.date)}'),
          Text('Город: ${order.city}${order.street != null ? ', ${order.street}' : ''}'),
          const SizedBox(height: 12),
          Text(order.description),
          const SizedBox(height: 16),
          if (order.imageUrl != null)
            ClipRRect(
              borderRadius: BorderRadius.circular(AppConstants.cardRadius),
              child: Image.network(order.imageUrl!, height: 180, fit: BoxFit.cover),
            ),
          const Spacer(),
          if (isExecutor)
            CustomButton(label: 'Откликнуться', onPressed: () => ScaffoldMessenger.of(context).showSnackBar(const SnackBar(content: Text('Отклик отправлен'))))
          else
            CustomButton(label: 'Написать исполнителю', onPressed: () {}),
        ],
      ),
    );
  }
}
