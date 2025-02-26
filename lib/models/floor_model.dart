import 'package:equatable/equatable.dart';
import 'package:json_annotation/json_annotation.dart';

import 'room_model.dart';

part 'floor_model.g.dart';

@JsonSerializable(explicitToJson: true)
class FloorModel extends Equatable {
  const FloorModel({
    required this.idFloor,
    required this.name,
    required this.rooms,
  });

  factory FloorModel.fromJson(Map<String, dynamic> json) => _$FloorModelFromJson(json);
  Map<String, dynamic> toJson() => _$FloorModelToJson(this);

  final int idFloor;
  final String name;
  final List<RoomModel> rooms;

  FloorModel copyWith({
    String? name,
    List<RoomModel>? rooms,
  }) {
    return FloorModel(
      idFloor: idFloor,
      name: name ?? this.name,
      rooms: rooms ?? this.rooms,
    );
  }

  @override
  List<Object> get props => <Object>[idFloor, name, rooms];
}
