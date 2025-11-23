import '../../domain/entities/order.dart';

class OrderModel extends Order {
  const OrderModel({
    required super.id,
    required super.title,
    required super.category,
    required super.price,
    required super.date,
    required super.city,
    required super.description,
    super.imageUrl,
    super.phone,
    super.street,
    super.isPremium,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) => OrderModel(
        id: json['id'] as int,
        title: json['title'] as String,
        category: json['category'] as String,
        price: (json['price'] as num).toDouble(),
        date: DateTime.parse(json['date'] as String),
        city: json['city'] as String,
        description: json['description'] as String,
        imageUrl: json['imageUrl'] as String?,
        phone: json['phone'] as String?,
        street: json['street'] as String?,
        isPremium: json['isPremium'] as bool? ?? false,
      );
}
