part of 'operation_bloc.dart';

sealed class OperationState extends Equatable {
  @override
  List<Object?> get props => <Object?>[];
}

class OperationInitial extends OperationState {}

class OperationLoaded extends OperationState {
  OperationLoaded(this.building);

  final BuildingModel building;

  @override
  List<BuildingModel> get props => <BuildingModel>[building];
}
