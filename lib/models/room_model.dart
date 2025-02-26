import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:locks_flutter/models/event_room_model.dart';

part 'room_model.g.dart';

@JsonSerializable(explicitToJson: true)
class RoomModel extends Equatable {
  const RoomModel({
    required this.idRoom,
    required this.name,
    required this.status,
    this.events = const <EventRoomModel>[],
  });

  factory RoomModel.fromJson(Map<String, dynamic> json) => _$RoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$RoomModelToJson(this);

  RoomModel copyWith({
    String? name,
    String? status,
    List<EventRoomModel>? events,
  }) {
    return RoomModel(
      idRoom: idRoom,
      name: name ?? this.name,
      status: status ?? this.status,
      events: events ?? this.events,
    );
  }

  final int idRoom;
  final String name;

  // available | not_available | ready | in_progress | SALTO | prioridad
  final String status;

  final List<EventRoomModel> events;

  @override
  List<Object> get props => <Object>[idRoom, name, status];

  @override
  String toString() => 'room: {name: $name, status: $status}';
}
