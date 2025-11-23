import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../core/constants/app_constants.dart';
import '../../core/widgets/custom_button.dart';
import 'cubit/create_order_cubit.dart';

class CreateOrderPage extends StatefulWidget {
  const CreateOrderPage({super.key});

  @override
  State<CreateOrderPage> createState() => _CreateOrderPageState();
}

class _CreateOrderPageState extends State<CreateOrderPage> {
  int step = 0;
  final titleController = TextEditingController();
  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final cityController = TextEditingController(text: 'Алматы');
  final streetController = TextEditingController();
  final priceController = TextEditingController(text: '10000');

  @override
  Widget build(BuildContext context) {
    final cubit = context.watch<CreateOrderCubit>();
    final steps = [
      _Step(title: 'Название заказа', child: TextField(controller: titleController, decoration: const InputDecoration(hintText: 'Например, ремонт крана'))),
      _Step(title: 'Описание + фото', child: TextField(controller: descriptionController, decoration: const InputDecoration(hintText: 'Полное описание'), maxLines: 4)),
      _Step(title: 'Дата + время', child: TextField(controller: dateController, decoration: const InputDecoration(hintText: '12 мая, 12:00'))),
      _Step(title: 'Адрес', child: Column(children: [TextField(controller: cityController, decoration: const InputDecoration(hintText: 'Город')), const SizedBox(height: 12), TextField(controller: streetController, decoration: const InputDecoration(hintText: 'Улица'))])),
      _Step(title: 'Цена', child: Column(children: [TextField(controller: priceController, decoration: const InputDecoration(hintText: 'Цена')), const SizedBox(height: 12), const Text('Фиксированная / договорная / часовая')])),
    ];

    return Scaffold(
      appBar: AppBar(title: const Text('Создание заказа')),
      body: Padding(
        padding: const EdgeInsets.all(AppConstants.padding),
        child: Column(
          children: [
            Row(
              children: List.generate(
                steps.length,
                (index) => Expanded(
                  child: Container(
                    margin: const EdgeInsets.symmetric(horizontal: 4),
                    height: 6,
                    decoration: BoxDecoration(
                      color: index <= step ? Theme.of(context).colorScheme.primary : Colors.grey.shade300,
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),
            Expanded(child: steps[step]),
            if (cubit.state.submitting) const CircularProgressIndicator(),
            const SizedBox(height: 12),
            Row(
              children: [
                if (step > 0)
                  Expanded(
                    child: CustomButton(
                      label: 'Назад',
                      outlined: true,
                      onPressed: () => setState(() => step -= 1),
                    ),
                  ),
                if (step > 0) const SizedBox(width: 8),
                Expanded(
                  child: CustomButton(
                    label: step == steps.length - 1 ? 'Опубликовать' : 'Далее',
                    onPressed: () async {
                      if (step == steps.length - 1) {
                        context.read<CreateOrderCubit>().update(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: DateTime.now().add(const Duration(days: 1)),
                              city: cityController.text,
                              street: streetController.text,
                              price: double.tryParse(priceController.text) ?? 0,
                            );
                        await context.read<CreateOrderCubit>().submit();
                        if (mounted) Navigator.of(context).pop();
                      } else {
                        setState(() => step += 1);
                      }
                    },
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text('Подтверждение номера через SMS будет автоматически отправлено'),
          ],
        ),
      ),
    );
  }
}

class _Step extends StatelessWidget {
  final String title;
  final Widget child;
  const _Step({required this.title, required this.child});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(title, style: const TextStyle(fontWeight: FontWeight.w700, fontSize: 18)),
        const SizedBox(height: 12),
        child,
      ],
    );
  }
}
