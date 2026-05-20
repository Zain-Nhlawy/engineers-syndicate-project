
import '../data/models/building_model.dart';

abstract class BuildingsState {}

class BuildingsInitial extends BuildingsState {}
class BuildingsLoading extends BuildingsState {}
class BuildingsSuccess extends BuildingsState {
  final List<BuildingModel> buildings;
  BuildingsSuccess(this.buildings);
}
class BuildingsError extends BuildingsState {
  final String error;
  BuildingsError(this.error);
}