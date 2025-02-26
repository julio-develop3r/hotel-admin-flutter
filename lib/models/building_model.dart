import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:locks_flutter/models/room_model.dart';
import 'package:locks_flutter/shared/consts.dart';

import 'floor_model.dart';

part 'building_model.g.dart';

@JsonSerializable(explicitToJson: true)
class BuildingModel extends Equatable {
  const BuildingModel({
    this.idBuilding,
    required this.name,
    required this.floors,
  });

  factory BuildingModel.fromJson(Map<String, dynamic> json) => _$BuildingModelFromJson(json);
  Map<String, dynamic> toJson() => _$BuildingModelToJson(this);

  // @JsonKey(name: 'cancelCommission', toJson: toNumber, fromJson: fromNumber)

  final String? idBuilding;
  final String name;
  final List<FloorModel> floors;

  BuildingModel copyWith({
    String? idBuilding,
    String? name,
    List<FloorModel>? floors,
  }) {
    return BuildingModel(
      idBuilding: idBuilding ?? this.idBuilding,
      name: name ?? this.name,
      floors: floors ?? this.floors,
    );
  }

  String percentageCompleted() {
    int roomsCount = 0;

    for (int i = 0; i < floors.length; i++) {
      roomsCount += floors[i].rooms.length;
    }

    final int roomsCompleted = floors.fold(
        0,
        (int previousValue, FloorModel element) =>
            previousValue + element.rooms.where((RoomModel element) => element.status == StatusTypes.salto).length);

    return ((roomsCompleted / roomsCount) * 100).toStringAsFixed(1);
  }

  @override
  List<Object?> get props => <Object?>[idBuilding, name, floors];
}
