part of 'room_bloc.dart';

final class RoomState extends Equatable {
  const RoomState(this.room, this.prevState, {this.comment = ''});

  final RoomModel room;
  final String prevState;
  final String comment;

  RoomState copyWith({
    RoomModel? room,
    String? prevState,
    String? comment,
  }) {
    return RoomState(
      room ?? this.room,
      prevState ?? this.prevState,
      comment: comment ?? this.comment,
    );
  }

  @override
  List<Object> get props => <Object>[room, comment];
}
