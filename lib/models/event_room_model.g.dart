// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_room_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

EventRoomModel _$EventRoomModelFromJson(Map<String, dynamic> json) =>
    EventRoomModel(
      user: json['user'] as String,
      description: json['description'] as String,
      date: DateTime.parse(json['date'] as String),
      comment: json['comment'] as String?,
    );

Map<String, dynamic> _$EventRoomModelToJson(EventRoomModel instance) =>
    <String, dynamic>{
      'user': instance.user,
      'description': instance.description,
      'date': instance.date.toIso8601String(),
      'comment': instance.comment,
    };
