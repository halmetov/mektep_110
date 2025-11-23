import 'package:equatable/equatable.dart';

class Order extends Equatable {
  final int id;
  final String title;
  final String category;
  final double price;
  final DateTime date;
  final String city;
  final String? street;
  final String description;
  final String? imageUrl;
  final String? phone;
  final bool isPremium;

  const Order({
    required this.id,
    required this.title,
    required this.category,
    required this.price,
    required this.date,
    required this.city,
    this.street,
    required this.description,
    this.imageUrl,
    this.phone,
    this.isPremium = false,
  });

  @override
  List<Object?> get props => [id, title, category, price, date, city, street, description, imageUrl, phone, isPremium];
}
