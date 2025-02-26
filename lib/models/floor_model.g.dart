// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'floor_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

FloorModel _$FloorModelFromJson(Map<String, dynamic> json) => FloorModel(
      idFloor: json['idFloor'] as int,
      name: json['name'] as String,
      rooms: (json['rooms'] as List<dynamic>)
          .map((e) => RoomModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$FloorModelToJson(FloorModel instance) =>
    <String, dynamic>{
      'idFloor': instance.idFloor,
      'name': instance.name,
      'rooms': instance.rooms.map((e) => e.toJson()).toList(),
    };
