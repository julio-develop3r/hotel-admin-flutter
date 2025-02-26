part of 'buildings_bloc.dart';

sealed class BuildingsEvent extends Equatable {
  const BuildingsEvent();

  @override
  List<Object> get props => <Object>[];
}

// class SubscriptionRequested extends BuildingsEvent {}

class FetchBuildings extends BuildingsEvent {}

class DeleteBuilding extends BuildingsEvent {
  const DeleteBuilding(this.idBuilding);

  final String idBuilding;
}
