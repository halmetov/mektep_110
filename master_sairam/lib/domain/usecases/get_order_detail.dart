import '../entities/order.dart';
import '../repositories/order_repository.dart';

class GetOrderDetail {
  final OrderRepository repository;

  GetOrderDetail(this.repository);

  Future<Order> call(int id) => repository.getOrderById(id);
}
