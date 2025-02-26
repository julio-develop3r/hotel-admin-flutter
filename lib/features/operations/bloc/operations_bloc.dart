import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:locks_flutter/api/buildings_provider.dart';
import 'package:locks_flutter/models/building_model.dart';

part 'operations_event.dart';
part 'operations_state.dart';

class OperationsBloc extends Bloc<OperationsEvent, OperationsState> {
  OperationsBloc() : super(const OperationsInitial()) {
    on<FetchBuildings>(_onFetchBuildings);
  }

  final BuildingsProvider _buldingsProvider = BuildingsProvider();

  Future<void> _onFetchBuildings(FetchBuildings event, Emitter<OperationsState> emit) async {
    print('\n Fetch Buildings \n\n');
    final List<BuildingModel> buildings = await _buldingsProvider.getBuildings();
    print('Buildings $buildings');
    emit(OperationsLoaded(buildings));
  }
}
