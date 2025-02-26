part of 'operations_bloc.dart';

sealed class OperationsEvent extends Equatable {
  const OperationsEvent();

  @override
  List<Object> get props => <Object>[];
}

class FetchBuildings extends OperationsEvent {}
