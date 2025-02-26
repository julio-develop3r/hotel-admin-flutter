import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:locks_flutter/models/building_model.dart';

import 'base_data_provider.dart';

class BuildingsProvider extends BaseDataProvider {
  ///

  Future<BuildingModel> getBuilding(String idBuilding) async {
    final Map<String, dynamic>? data = (await api.firestore //
            .collection('buildings')
            .doc(idBuilding)
            .get())
        .data();

    return BuildingModel.fromJson(data!);
  }

  Future<List<BuildingModel>> getBuildings() async {
    return (await api.firestore.collection('buildings').get())
        .docs
        .map((QueryDocumentSnapshot<Map<String, dynamic>> e) => e.data())
        .map((Map<String, dynamic> e) => BuildingModel.fromJson(e))
        .toList();
  }

  Future<void> addBuilding(BuildingModel building) async {
    final DocumentReference<Map<String, dynamic>> buildingRef = api.firestore.collection('buildings').doc();

    await buildingRef.set(building.copyWith(idBuilding: buildingRef.id).toJson());
  }

  /// *** Add with subcollections ***
  // Future<void> addBuilding(BuildingModel building) async {
  //   final WriteBatch batch = api.firestore.batch();

  //   final DocumentReference<Map<String, dynamic>> buildingRef = api.firestore.collection('buildings').doc();

  //   batch.set(buildingRef, building.copyWith(idBuilding: buildingRef.id).toJson());

  //   for (final FloorModel floor in building.floors) {
  //     final DocumentReference<Map<String, dynamic>> floorRef = buildingRef.collection('floors').doc();
  //     batch.set(floorRef, floor.toJson());

  //     for (final RoomModel room in floor.rooms) {
  //       final DocumentReference<Map<String, dynamic>> roomRef = floorRef.collection('rooms').doc();
  //       batch.set(roomRef, room.toJson());
  //     }
  //   }

  //   await batch.commit();
  // }

  Future<void> delete(String idBuilding) async {
    await api.firestore.collection('buildings').doc(idBuilding).delete();
  }

  Future<BuildingModel> updateBuilding(BuildingModel building) async {
    final DocumentReference<Map<String, dynamic>> buildingRef =
        api.firestore.collection('buildings').doc(building.idBuilding);

    await buildingRef.update(building.toJson());

    return BuildingModel.fromJson((await buildingRef.get()).data()!);
  }
}
