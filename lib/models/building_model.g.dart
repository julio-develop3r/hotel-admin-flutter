// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'building_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BuildingModel _$BuildingModelFromJson(Map<String, dynamic> json) =>
    BuildingModel(
      idBuilding: json['idBuilding'] as String,
      name: json['name'] as String,
      floors: (json['floors'] as List<dynamic>)
          .map((e) => FloorModel.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$BuildingModelToJson(BuildingModel instance) =>
    <String, dynamic>{
      'idBuilding': instance.idBuilding,
      'name': instance.name,
      'floors': instance.floors.map((e) => e.toJson()).toList(),
    };
