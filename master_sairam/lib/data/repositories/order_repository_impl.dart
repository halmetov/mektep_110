import '../../domain/entities/order.dart';
import '../../domain/repositories/order_repository.dart';
import '../api/api_service.dart';

class OrderRepositoryImpl implements OrderRepository {
  final ApiService apiService;

  OrderRepositoryImpl(this.apiService);

  @override
  Future<void> createOrder(Order order) => apiService.createOrder(order);

  @override
  Future<Order> getOrderById(int id) => apiService.getOrderById(id);

  @override
  Future<List<Order>> getOrders() => apiService.getOrders();
}
