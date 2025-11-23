import '../entities/specialist.dart';

abstract class SpecialistRepository {
  Future<List<Specialist>> getSpecialists();
}
