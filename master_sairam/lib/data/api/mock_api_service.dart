import '../../domain/entities/auth_response.dart';
import '../../domain/entities/order.dart';
import '../../domain/entities/specialist.dart';
import 'api_service.dart';

class MockApiService implements ApiService {
  final List<Order> _orders = [
    Order(
      id: 1,
      title: 'Установить раковину',
      category: 'Сантехник',
      price: 18000,
      date: DateTime.now().add(const Duration(days: 1)),
      city: 'Алматы',
      street: 'Абая 24',
      description: 'Нужно заменить раковину и подключить сифон. Фото приложено.',
      imageUrl: 'https://images.unsplash.com/photo-1582719478250-c89cae4dc85b?auto=format&fit=crop&w=800&q=60',
      phone: '+7 777 222 33 44',
      isPremium: true,
    ),
    Order(
      id: 2,
      title: 'Починить розетку',
      category: 'Электрик',
      price: 12000,
      date: DateTime.now().add(const Duration(days: 2)),
      city: 'Астана',
      street: 'Сейфуллина 10',
      description: 'Розетка искрит, нужна замена. Адрес покажу после оплаты тарифа.',
      imageUrl: null,
      phone: null,
      isPremium: false,
    ),
  ];

  final List<Specialist> _specialists = [
    Specialist(
      id: 1,
      name: 'Айдос Нурланов',
      categories: const ['Сантехник', 'Электрик'],
      experience: 5,
      rate: 8000,
      avatar: 'https://images.unsplash.com/photo-1535713875002-d1d0cf377fde?auto=format&fit=crop&w=200&q=80',
      bio: 'Работаю чисто и быстро, гарантия 6 месяцев.',
    ),
    Specialist(
      id: 2,
      name: 'Мария Исаева',
      categories: const ['Маляр', 'Мебельщик'],
      experience: 7,
      rate: 9000,
      avatar: 'https://images.unsplash.com/photo-1524504388940-b1c1722653e1?auto=format&fit=crop&w=200&q=80',
      bio: 'Покраска, сборка мебели, мелкий ремонт.',
    ),
  ];

  @override
  Future<AuthResponse> login(String phone) async {
    await Future.delayed(const Duration(milliseconds: 400));
    return AuthResponse(token: 'mock_token_${phone.hashCode}', userName: 'Гость');
  }

  @override
  Future<void> createOrder(Order order) async {
    await Future.delayed(const Duration(milliseconds: 300));
    _orders.add(order.copyWith(id: _orders.length + 1));
  }

  @override
  Future<Order> getOrderById(int id) async {
    await Future.delayed(const Duration(milliseconds: 300));
    return _orders.firstWhere((o) => o.id == id);
  }

  @override
  Future<List<Order>> getOrders() async {
    await Future.delayed(const Duration(milliseconds: 500));
    return List.of(_orders);
  }

  @override
  Future<List<Specialist>> getSpecialists() async {
    await Future.delayed(const Duration(milliseconds: 400));
    return List.of(_specialists);
  }
}

extension on Order {
  Order copyWith({int? id}) {
    return Order(
      id: id ?? this.id,
      title: title,
      category: category,
      price: price,
      date: date,
      city: city,
      street: street,
      description: description,
      imageUrl: imageUrl,
      phone: phone,
      isPremium: isPremium,
    );
  }
}
