import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:locks_flutter/api/buildings_provider.dart';
import 'package:locks_flutter/models/building_model.dart';

part 'buildings_event.dart';
part 'buildings_state.dart';

class BuildingsBloc extends Bloc<BuildingsEvent, BuildingsState> {
  BuildingsBloc() : super(const BuildingsInitial()) {
    // on<SubscriptionRequested>(_onSubscriptionRequested);
    on<FetchBuildings>(_onFetchBuildings);
    on<DeleteBuilding>(_onDeleteBuilding);
  }

  final BuildingsProvider _buldingsProvider = BuildingsProvider();

  // Future<void> _onSubscriptionRequested(SubscriptionRequested event, Emitter<BuildingsState> emit) async {
  //   await emit.forEach<List<BuildingModel>>(
  //     _buildingsRepo.buildingsStream,
  //     onData: (List<BuildingModel> buildings) => BuildingsInitial(buildings),
  //     onError: (_, __) => state,
  //   );
  // }

  Future<void> _onFetchBuildings(FetchBuildings event, Emitter<BuildingsState> emit) async {
    print('\n Fetch Buildings \n\n');
    final List<BuildingModel> buildings = await _buldingsProvider.getBuildings();
    print('Buildings $buildings');
    emit(BuildingsLoaded(buildings));
  }

  void _onDeleteBuilding(DeleteBuilding event, Emitter<BuildingsState> emit) {
    _buldingsProvider.delete(event.idBuilding);
    add(FetchBuildings());
  }
}
