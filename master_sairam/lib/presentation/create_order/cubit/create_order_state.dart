part of 'create_order_cubit.dart';

class CreateOrderState extends Equatable {
  final String title;
  final String description;
  final DateTime date;
  final String city;
  final String street;
  final String category;
  final double price;
  final bool submitting;
  final bool completed;

  const CreateOrderState({
    required this.title,
    required this.description,
    required this.date,
    required this.city,
    required this.street,
    required this.category,
    required this.price,
    required this.submitting,
    required this.completed,
  });

  factory CreateOrderState.initial() => CreateOrderState(
        title: '',
        description: '',
        date: DateTime.now().add(const Duration(days: 1)),
        city: 'Алматы',
        street: '',
        category: 'Сантехник',
        price: 10000,
        submitting: false,
        completed: false,
      );

  CreateOrderState copyWith({
    String? title,
    String? description,
    DateTime? date,
    String? city,
    String? street,
    String? category,
    double? price,
    bool? submitting,
    bool? completed,
  }) {
    return CreateOrderState(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      city: city ?? this.city,
      street: street ?? this.street,
      category: category ?? this.category,
      price: price ?? this.price,
      submitting: submitting ?? this.submitting,
      completed: completed ?? this.completed,
    );
  }

  @override
  List<Object?> get props => [title, description, date, city, street, category, price, submitting, completed];
}
