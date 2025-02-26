import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:locks_flutter/api/buildings_provider.dart';
import 'package:locks_flutter/models/building_model.dart';
import 'package:locks_flutter/models/floor_model.dart';
import 'package:locks_flutter/models/room_model.dart';
import 'package:locks_flutter/shared/consts.dart';
import 'package:locks_flutter/shared/print.dart';

part 'add_building_state.dart';

class AddBuildingCubit extends Cubit<AddBuildingState> {
  AddBuildingCubit(BuildingModel? building)
      : super(EditingBuilding(
          building ??
              const BuildingModel(
                name: 'Hotel #',
                floors: <FloorModel>[],
              ),
        ));

  final BuildingsProvider _buildingsProvider = BuildingsProvider();

  void updateFloors(String floorsValue, String roomsValue) {
    final EditingBuilding prevState = state as EditingBuilding;

    try {
      if (floorsValue.isEmpty) {
        throw 'Indica el numero de pisos';
      }

      if (roomsValue.isEmpty) {
        throw 'Indica el numero de cuartos';
      }

      final int floorCount = int.parse(floorsValue);
      final int roomCount = int.parse(roomsValue);

      if (floorCount > 25) {
        throw 'Para la autogeneración el limite de pisos es de 25, si necesitas más puedes agregarlos manualmente.';
      }

      if (roomCount > 100) {
        throw 'Para la autogeneración el limite de cuartos es de 100, si necesitas más puedes agregarlos manualmente.';
      }

      final List<FloorModel> floors = List<FloorModel>.generate(
        floorCount,
        (int index) => FloorModel(
          idFloor: index + 1,
          name: 'Piso ${index + 1}',
          rooms: List<RoomModel>.generate(
            roomCount,
            (int index) => RoomModel(
              idRoom: index + 1,
              name: 'Room ${index + 1}',
              status: StatusTypes.notAvailable,
            ),
          ),
        ),
      );

      emit(EditingBuilding(prevState.building.copyWith(floors: floors)));
    } catch (e) {
      emit(BuildingError(e.toString()));
      emit(prevState);
    }
  }

  Future<void> saveBuilding(String name) async {
    final EditingBuilding st = state as EditingBuilding;

    try {
      emit(BuildingLoading());

      final String? idBuilding = st.building.idBuilding;

      if (idBuilding != null) {
        await _buildingsProvider.updateBuilding(st.building.copyWith(name: name));
        printSuccess('[UpdatedBuilding]}');
      } else {
        await _buildingsProvider.addBuilding(st.building.copyWith(name: name));
        printSuccess('[SaveBuilding]}');
      }
      emit(BuildingSaved());
    } catch (e) {
      printError('[SaveBuilding] ${e.toString()}');
      emit(BuildingError(e.toString()));
      emit(st);
    }
  }

  void addFloor() {
    final EditingBuilding prevState = state as EditingBuilding;
    final List<FloorModel> floors = <FloorModel>[...prevState.building.floors];
    // FloorModel(idFloor: 1, name: name, rooms: rooms)
    emit(EditingBuilding(
      prevState.building.copyWith(floors: <FloorModel>[
        ...floors,
        FloorModel(
            idFloor: floors.last.idFloor + 1,
            name: 'Piso ${floors.last.idFloor + 1}',
            rooms: const <RoomModel>[RoomModel(idRoom: 1, name: 'Room 1', status: StatusTypes.notAvailable)])
      ]),
    ));
  }

  void removeFloor(int indexFloor) {
    final EditingBuilding prevState = state as EditingBuilding;

    final BuildingModel building = prevState.building;
    final List<FloorModel> floors = <FloorModel>[...building.floors];

    floors.removeAt(indexFloor);

    emit(EditingBuilding(building.copyWith(floors: floors)));
  }

  void updateFloor(FloorModel floor, int indexFloor) {
    final EditingBuilding st = state as EditingBuilding;

    final List<FloorModel> floors = <FloorModel>[...st.building.floors];

    floors[indexFloor] = floor;
    emit(EditingBuilding(st.building.copyWith(floors: floors)));
  }

  void addRoom(int indexFloor) {
    final EditingBuilding prevState = state as EditingBuilding;
    final BuildingModel building = prevState.building;
    final List<FloorModel> floors = <FloorModel>[...building.floors];

    final FloorModel floor = floors[indexFloor];

    floors[indexFloor] = floor.copyWith(rooms: <RoomModel>[
      ...floor.rooms,
      RoomModel(
        idRoom: floor.rooms.last.idRoom + 1,
        name: 'Room ${floor.rooms.last.idRoom + 1}',
        status: StatusTypes.notAvailable,
      )
    ]);
    emit(EditingBuilding(building.copyWith(floors: floors)));
  }

  void removeRoom(int indexFloor, int indexRoom) {
    final EditingBuilding prevState = state as EditingBuilding;
    final BuildingModel building = prevState.building;
    final List<FloorModel> floors = <FloorModel>[...building.floors];

    final FloorModel floor = floors[indexFloor];
    final List<RoomModel> rooms = <RoomModel>[...floor.rooms];
    rooms.removeAt(indexRoom);

    floors[indexFloor] = floor.copyWith(rooms: rooms);
    emit(EditingBuilding(building.copyWith(floors: floors)));
  }

  void updateRoom(int indexFloor, int indexRoom, RoomModel room) {
    final EditingBuilding st = state as EditingBuilding;

    final BuildingModel building = st.building;
    final List<FloorModel> floors = <FloorModel>[...building.floors];

    final FloorModel floor = floors[indexFloor];
    final List<RoomModel> rooms = <RoomModel>[...floor.rooms];
    rooms[indexRoom] = room;

    floors[indexFloor] = floor.copyWith(rooms: rooms);
    emit(EditingBuilding(building.copyWith(floors: floors)));
  }
}
