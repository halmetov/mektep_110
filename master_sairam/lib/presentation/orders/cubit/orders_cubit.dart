import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/order.dart';
import '../../../domain/usecases/get_order_detail.dart';
import '../../../domain/usecases/get_orders.dart';

part 'orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  final GetOrders getOrders;
  final GetOrderDetail getOrderDetail;

  OrdersCubit({required this.getOrders, required this.getOrderDetail}) : super(OrdersInitial());

  Future<void> loadOrders() async {
    emit(OrdersLoading());
    try {
      final items = await getOrders();
      emit(OrdersLoaded(items));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }

  Future<void> loadOrder(int id) async {
    emit(OrdersLoading());
    try {
      final order = await getOrderDetail(id);
      emit(OrderDetailLoaded(order));
    } catch (e) {
      emit(OrdersError(e.toString()));
    }
  }
}
