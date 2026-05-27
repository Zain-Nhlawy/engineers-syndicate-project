import 'package:engineers_syndicate_project/features/halls/data/model/halls_model.dart';
import 'package:engineers_syndicate_project/features/halls/data/services/halls_services.dart';
import 'package:engineers_syndicate_project/features/halls/view%20model/halls_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HallsCubit extends Cubit<HallsState> {
  final HallsServices _hallsServices = HallsServices();

  List<HallsModel> halls = [];

  HallsCubit() : super(const HallsInitial());

  void loadHalls() async {
    emit(HallsLoading());
    try {
      halls = await _hallsServices.getHalls();
      emit(HallsLoaded(halls: halls));
    } catch (e) {
      emit(HallsError(message: "Error fetching halls: $e"));
    }
  }
}
