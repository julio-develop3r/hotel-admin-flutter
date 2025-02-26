import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:locks_flutter/features/add_building/add_building_screen.dart';
import 'package:locks_flutter/models/building_model.dart';

import 'bloc/buildings_bloc.dart';

class BuildingsScreen extends StatelessWidget {
  const BuildingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BuildingsBloc>(
      create: (_) => BuildingsBloc()..add(FetchBuildings()),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          final BuildingsBloc bloc = context.read<BuildingsBloc>();
          final BuildingState? res = await context.push('/buildings/add');

          if (res == BuildingState.saved) {
            bloc.add(FetchBuildings());
          }
        },
        child: const Icon(Icons.add),
      ),
      body: BlocBuilder<BuildingsBloc, BuildingsState>(
        builder: (BuildContext context, BuildingsState state) {
          if (state is! BuildingsLoaded) {
            return const Center(child: CircularProgressIndicator());
          }

          return ListView.builder(
            itemCount: state.buildings.length,
            itemBuilder: (_, int index) {
              final BuildingModel building = state.buildings[index];

              return ListTile(
                leading: const Icon(Icons.apartment),
                title: Text(building.name),
                subtitle: Text('Pisos ${building.floors.length}'),
                trailing: IconButton(
                  onPressed: () async {
                    final String res = await showDialog(
                          context: context,
                          builder: (BuildContext ctx) => AlertDialog(
                            title: const Text('¡Advertencia!'),
                            content: const Text(
                              '¿Estás seguro que deséas eliminar el Hotel?, Se borrará permanentemente.',
                            ),
                            actions: <Widget>[
                              TextButton(onPressed: () => Navigator.of(ctx).pop('yes'), child: const Text('Sí')),
                              ElevatedButton(
                                  onPressed: () => Navigator.of(ctx).pop('no'), child: const Text('Cancelar')),
                            ],
                          ),
                        ) ??
                        'no';

                    if (context.mounted && res == 'yes') {
                      context.read<BuildingsBloc>().add(DeleteBuilding(building.idBuilding!));
                    }
                  },
                  icon: const Icon(Icons.delete),
                ),
                onTap: () async {
                  final BuildingsBloc bloc = context.read<BuildingsBloc>();
                  final BuildingState? res = await context.push('/buildings/add', extra: building);

                  if (res == BuildingState.saved) {
                    bloc.add(FetchBuildings());
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
