import 'package:locks_flutter/models/building_model.dart';
import 'package:rxdart/rxdart.dart';

@Deprecated('Unused repository')
class BuildingsRepository {
  final BehaviorSubject<List<BuildingModel>> _buildingsController =
      BehaviorSubject<List<BuildingModel>>.seeded(<BuildingModel>[]);

  ValueStream<List<BuildingModel>> get buildingsStream => _buildingsController.stream;

  void addBuilding(BuildingModel building) {
    _buildingsController.add(<BuildingModel>[..._buildingsController.value, building]);
  }

  void delete(int index) {
    final List<BuildingModel> array = <BuildingModel>[..._buildingsController.value];
    array.removeAt(index);
    _buildingsController.add(array);
  }
}
