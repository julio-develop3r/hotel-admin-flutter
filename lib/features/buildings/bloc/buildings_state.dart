part of 'buildings_bloc.dart';

sealed class BuildingsState extends Equatable {
  const BuildingsState();

  @override
  List<Object> get props => <Object>[];
}

final class BuildingsInitial extends BuildingsState {
  const BuildingsInitial();
}

final class BuildingsLoaded extends BuildingsState {
  const BuildingsLoaded(this.buildings);

  final List<BuildingModel> buildings;

  @override
  List<List<BuildingModel>> get props => <List<BuildingModel>>[buildings];
}
