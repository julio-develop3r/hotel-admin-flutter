part of 'operation_bloc.dart';

sealed class OperationEvent extends Equatable {
  const OperationEvent();

  @override
  List<Object> get props => <Object>[];
}

class RefreshBuilding extends OperationEvent {
  const RefreshBuilding(this.building);

  final BuildingModel building;

  @override
  List<BuildingModel> get props => <BuildingModel>[building];
}

class UpdateRoom extends OperationEvent {
  const UpdateRoom(this.indexFloor, this.room, this.indexRoom, this.prevState, this.comment);

  final int indexFloor;
  final RoomModel room;
  final int indexRoom;
  final String prevState;
  final String comment;
}
