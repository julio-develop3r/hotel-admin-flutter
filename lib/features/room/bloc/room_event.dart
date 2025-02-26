part of 'room_bloc.dart';

sealed class RoomEvent extends Equatable {
  const RoomEvent();

  @override
  List<Object> get props => <Object>[];
}

class UpdateRoom extends RoomEvent {
  const UpdateRoom(this.room);

  final RoomModel room;
}

class UpdateComment extends RoomEvent {
  const UpdateComment(this.comment);

  final String comment;
}
