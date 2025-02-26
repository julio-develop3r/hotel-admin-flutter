// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

RoomModel _$RoomModelFromJson(Map<String, dynamic> json) => RoomModel(
      idRoom: json['idRoom'] as int,
      name: json['name'] as String,
      status: json['status'] as String,
      events: (json['events'] as List<dynamic>?)
              ?.map((e) => EventRoomModel.fromJson(e as Map<String, dynamic>))
              .toList() ??
          const <EventRoomModel>[],
    );

Map<String, dynamic> _$RoomModelToJson(RoomModel instance) => <String, dynamic>{
      'idRoom': instance.idRoom,
      'name': instance.name,
      'status': instance.status,
      'events': instance.events.map((e) => e.toJson()).toList(),
    };
