import '../../domain/entities/specialist.dart';
import '../../domain/repositories/specialist_repository.dart';
import '../api/api_service.dart';

class SpecialistRepositoryImpl implements SpecialistRepository {
  final ApiService apiService;

  SpecialistRepositoryImpl(this.apiService);

  @override
  Future<List<Specialist>> getSpecialists() => apiService.getSpecialists();
}
