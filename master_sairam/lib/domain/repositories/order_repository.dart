import '../entities/order.dart';

abstract class OrderRepository {
  Future<List<Order>> getOrders();
  Future<Order> getOrderById(int id);
  Future<void> createOrder(Order order);
}
