import 'package:equatable/equatable.dart';

class Specialist extends Equatable {
  final int id;
  final String name;
  final List<String> categories;
  final int experience;
  final double rate;
  final String? avatar;
  final String? bio;

  const Specialist({
    required this.id,
    required this.name,
    required this.categories,
    required this.experience,
    required this.rate,
    this.avatar,
    this.bio,
  });

  @override
  List<Object?> get props => [id, name, categories, experience, rate, avatar, bio];
}
