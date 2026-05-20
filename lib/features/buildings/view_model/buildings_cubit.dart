
import 'package:engineers_syndicate_project/features/buildings/data/service/buildings_api_service.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'buildings_state.dart';

class BuildingsCubit extends Cubit<BuildingsState> {
  final BuildingsApiService buildingsApiService;

  BuildingsCubit({required this.buildingsApiService}) : super(BuildingsInitial());

  Future<void> fetchBuildings() async {
    emit(BuildingsLoading());
    try {
      final buildings = await buildingsApiService.getBuildings();
      emit(BuildingsSuccess(buildings));
    } catch (e) {
      emit(BuildingsError(e.toString().replaceAll('Exception: ', '')));
    }
  }
}