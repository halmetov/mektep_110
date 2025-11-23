import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/create_order.dart';

part 'create_order_state.dart';

class CreateOrderCubit extends Cubit<CreateOrderState> {
  final CreateOrderUseCase createOrder;

  CreateOrderCubit(this.createOrder) : super(CreateOrderState.initial());

  void update({String? title, String? description, DateTime? date, String? city, String? street, double? price, String? category}) {
    emit(state.copyWith(
      title: title,
      description: description,
      date: date,
      city: city,
      street: street,
      price: price,
      category: category,
    ));
  }

  Future<void> submit() async {
    emit(state.copyWith(submitting: true));
    final order = Order(
      id: DateTime.now().millisecondsSinceEpoch,
      title: state.title,
      category: state.category,
      price: state.price,
      date: state.date,
      city: state.city,
      street: state.street,
      description: state.description,
      isPremium: true,
    );
    await createOrder(order);
    emit(state.copyWith(submitting: false, completed: true));
  }
}
