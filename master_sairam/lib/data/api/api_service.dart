import '../../domain/entities/auth_response.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/specialist.dart';

abstract class ApiService {
  Future<List<Order>> getOrders();
  Future<Order> getOrderById(int id);
  Future<void> createOrder(Order order);
  Future<List<Specialist>> getSpecialists();
  Future<AuthResponse> login(String phone);
}
