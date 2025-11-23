import '../entities/specialist.dart';
import '../repositories/specialist_repository.dart';

class GetSpecialists {
  final SpecialistRepository repository;

  GetSpecialists(this.repository);

  Future<List<Specialist>> call() => repository.getSpecialists();
}
