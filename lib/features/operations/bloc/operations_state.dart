part of 'operations_bloc.dart';

sealed class OperationsState extends Equatable {
  const OperationsState();

  @override
  List<Object> get props => <Object>[];
}

final class OperationsInitial extends OperationsState {
  const OperationsInitial();
}

class OperationsLoaded extends OperationsState {
  const OperationsLoaded(this.buildings);

  final List<BuildingModel> buildings;

  @override
  List<List<BuildingModel>> get props => <List<BuildingModel>>[buildings];
}
