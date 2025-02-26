import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:equatable/equatable.dart';
import 'package:locks_flutter/api/buildings_provider.dart';
import 'package:locks_flutter/api/firestore_api.dart';
import 'package:locks_flutter/app/app_service.dart';
import 'package:locks_flutter/models/building_model.dart';
import 'package:locks_flutter/models/event_room_model.dart';
import 'package:locks_flutter/models/floor_model.dart';
import 'package:locks_flutter/models/room_model.dart';
import 'package:locks_flutter/shared/print.dart';

part 'operation_event.dart';
part 'operation_state.dart';

class OperationBloc extends Bloc<OperationEvent, OperationState> {
  OperationBloc(String idBuilding) : super(OperationInitial()) {
    on<RefreshBuilding>(_onRefreshBuilding);
    on<UpdateRoom>(_onUpdateRoom);

    _listener = FirestoreApi()
        .firestore //
        .collection('buildings')
        .doc(idBuilding)
        .snapshots()
        .listen(
      (DocumentSnapshot<Map<String, dynamic>> event) {
        printWarning('On change building${event.data()}');
        add(RefreshBuilding(BuildingModel.fromJson(event.data()!)));
      },
    );
  }

  final BuildingsProvider _buildingsProvider = BuildingsProvider();

  late final StreamSubscription<DocumentSnapshot<Map<String, dynamic>>> _listener;

  void _onRefreshBuilding(RefreshBuilding event, Emitter<OperationState> emit) {
    emit(OperationLoaded(event.building));
  }

  Future<void> _onUpdateRoom(UpdateRoom event, Emitter<OperationState> emit) async {
    final OperationState currState = state;

    if (currState is! OperationLoaded) {
      return;
    }

    final List<FloorModel> floors = <FloorModel>[...currState.building.floors];

    final FloorModel floor = floors[event.indexFloor];
    final List<RoomModel> rooms = <RoomModel>[...floor.rooms];

    rooms[event.indexRoom] = event.room.copyWith(events: <EventRoomModel>[
      _generateNewEvent(
        event.prevState,
        event.room.status,
        event.comment,
      ),
      ...event.room.events,
    ]);
    floors[event.indexFloor] = floor.copyWith(rooms: rooms);

    final BuildingModel newBuilding = await _buildingsProvider.updateBuilding(
      currState.building.copyWith(floors: floors),
    );

    emit(OperationLoaded(newBuilding));
  }

  EventRoomModel _generateNewEvent(String prevState, String newState, String comment) => EventRoomModel(
        user: AppService.instance.credential?.user?.email ?? 'Unknown',
        description: 'Cambio de $prevState a $newState',
        date: DateTime.now().toLocal(),
        comment: comment,
      );

  @override
  Future<void> close() {
    _listener.cancel();
    return super.close();
  }
}
