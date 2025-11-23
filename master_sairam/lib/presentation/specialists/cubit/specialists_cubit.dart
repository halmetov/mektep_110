import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../domain/entities/specialist.dart';
import '../../../domain/usecases/get_specialists.dart';

part 'specialists_state.dart';

class SpecialistsCubit extends Cubit<SpecialistsState> {
  final GetSpecialists getSpecialists;

  SpecialistsCubit(this.getSpecialists) : super(SpecialistsInitial());

  Future<void> load() async {
    emit(SpecialistsLoading());
    try {
      final data = await getSpecialists();
      emit(SpecialistsLoaded(data));
    } catch (e) {
      emit(SpecialistsError(e.toString()));
    }
  }
}
