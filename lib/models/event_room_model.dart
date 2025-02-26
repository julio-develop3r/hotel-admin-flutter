import 'package:json_annotation/json_annotation.dart';

part 'event_room_model.g.dart';

@JsonSerializable()
class EventRoomModel {
  const EventRoomModel({
    required this.user,
    required this.description,
    required this.date,
    this.comment,
  });

  factory EventRoomModel.fromJson(Map<String, dynamic> json) => _$EventRoomModelFromJson(json);
  Map<String, dynamic> toJson() => _$EventRoomModelToJson(this);

  final String user;
  final String description;
  final DateTime date;
  final String? comment;
}
