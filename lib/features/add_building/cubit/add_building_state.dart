part of 'add_building_cubit.dart';

// @immutable

sealed class AddBuildingState extends Equatable {
  const AddBuildingState();

  @override
  List<Object> get props => <Object>[];
}

final class EditingBuilding extends AddBuildingState {
  const EditingBuilding(this.building);

  final BuildingModel building;

  @override
  List<BuildingModel> get props => <BuildingModel>[building];
}

final class BuildingLoading extends AddBuildingState {}

final class BuildingSaved extends AddBuildingState {}

final class BuildingError extends AddBuildingState {
  const BuildingError(this.error);

  final String error;
}
