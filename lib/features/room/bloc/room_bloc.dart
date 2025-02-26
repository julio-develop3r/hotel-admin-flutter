import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:locks_flutter/models/room_model.dart';

part 'room_event.dart';
part 'room_state.dart';

class RoomBloc extends Bloc<RoomEvent, RoomState> {
  RoomBloc(this.room) : super(RoomState(room, room.status)) {
    on<UpdateRoom>(_onUpdateRoom);
    on<UpdateComment>(_onUpdateComment);
  }

  final RoomModel room;

  void _onUpdateRoom(UpdateRoom event, Emitter<RoomState> emit) {
    emit(state.copyWith(room: event.room, prevState: state.room.status));
  }

  void _onUpdateComment(UpdateComment event, Emitter<RoomState> emit) {
    emit(state.copyWith(comment: event.comment));
  }
}
