import '../../domain/entities/specialist.dart';

class SpecialistModel extends Specialist {
  const SpecialistModel({
    required super.id,
    required super.name,
    required super.categories,
    required super.experience,
    required super.rate,
    super.avatar,
    super.bio,
  });

  factory SpecialistModel.fromJson(Map<String, dynamic> json) => SpecialistModel(
        id: json['id'] as int,
        name: json['name'] as String,
        categories: List<String>.from(json['categories'] as List<dynamic>),
        experience: json['experience'] as int,
        rate: (json['rate'] as num).toDouble(),
        avatar: json['avatar'] as String?,
        bio: json['bio'] as String?,
      );
}
