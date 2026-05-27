import 'package:engineers_syndicate_project/features/halls/data/model/halls_model.dart';

abstract class HallsState {
  final int currentIndex;
  const HallsState(this.currentIndex);
}

class HallsInitial extends HallsState {
  const HallsInitial() : super(0);
}

class HallsLoading extends HallsState {
  const HallsLoading() : super(0);
}

class HallsLoaded extends HallsState {
  final List<HallsModel> halls;
  const HallsLoaded({required this.halls}) : super(0);
}

class HallsError extends HallsState {
  final String message;
  const HallsError({required this.message}) : super(0);
}