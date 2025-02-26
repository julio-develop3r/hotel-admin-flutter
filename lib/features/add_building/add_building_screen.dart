import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:locks_flutter/features/add_building/cubit/add_building_cubit.dart';
import 'package:locks_flutter/models/building_model.dart';
import 'package:locks_flutter/models/floor_model.dart';
import 'package:locks_flutter/models/room_model.dart';
import 'package:locks_flutter/shared/snackbars.dart';

enum BuildingState { saved }

class AddBuildingScreen extends StatelessWidget {
  const AddBuildingScreen(this.building, {super.key});

  final BuildingModel? building;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<AddBuildingCubit>(
      create: (_) => AddBuildingCubit(building),
      child: _View(building?.name),
    );
  }
}

class _View extends StatelessWidget {
  const _View(this.buildingName);

  final String? buildingName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(buildingName != null ? 'Editar Hotel' : 'Agregar Hotel')),
      body: _Form(buildingName),
    );
  }
}

class _Form extends StatefulWidget {
  const _Form(this.buildingName);

  final String? buildingName;

  @override
  State<_Form> createState() => __FormState();
}

class __FormState extends State<_Form> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _floorsController = TextEditingController();
  final TextEditingController _roomsController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.buildingName ?? 'Hotel #';
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddBuildingCubit, AddBuildingState>(
      listener: (BuildContext context, AddBuildingState state) {
        if (state is BuildingError) {
          ggShowSnackBar(context, content: state.error);
        }
        if (state is BuildingSaved) {
          context.pop(BuildingState.saved);
        }
      },
      builder: (_, AddBuildingState state) {
        if (state is! EditingBuilding) {
          return const Center(child: CircularProgressIndicator());
        }

        final bool hasFloors = state.building.floors.isNotEmpty;

        return Column(
          children: <Widget>[
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 8),
                      child: TextField(
                        controller: _nameController,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: 'Nombre',
                        ),
                      ),
                    ),
                    if (!hasFloors) ...<Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          children: <Widget>[
                            Expanded(
                              child: TextField(
                                controller: _floorsController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Pisos',
                                ),
                              ),
                            ),
                            Expanded(
                              child: TextField(
                                controller: _roomsController,
                                keyboardType: TextInputType.number,
                                decoration: const InputDecoration(
                                  border: OutlineInputBorder(),
                                  hintText: 'Cuartos (por piso)',
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () => context.read<AddBuildingCubit>().updateFloors(
                              _floorsController.text,
                              _roomsController.text,
                            ),
                        child: const Text('Generar pisos'),
                      ),
                    ],
                    const Divider(),
                    if (hasFloors)
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 4.0, horizontal: 12),
                        child: Row(
                          children: <Widget>[
                            const Icon(Icons.info, size: 20, color: Colors.blue),
                            const SizedBox(width: 4),
                            Expanded(
                              child: Text(
                                'Para editar el nombre de un piso o una habitación, manten presionado sobre de el por un momento',
                                style: Theme.of(context).textTheme.labelSmall,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ListView.builder(
                      physics: const NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: state.building.floors.length,
                      itemBuilder: (_, int index) => _FloorWidget(state.building.floors[index], index),
                    ),
                    if (hasFloors)
                      ElevatedButton(
                        onPressed: () => context.read<AddBuildingCubit>().addFloor(),
                        child: const Text('Agregar piso '),
                      )
                  ],
                ),
              ),
            ),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () => context.read<AddBuildingCubit>().saveBuilding(_nameController.text),
                child: const Text('Guardar'),
              ),
            )
          ],
        );
      },
    );
  }
}

class _FloorWidget extends StatelessWidget {
  const _FloorWidget(this.floor, this.indexFloor);

  final FloorModel floor;
  final int indexFloor;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Ink(
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.only(topLeft: Radius.circular(20), topRight: Radius.circular(20)),
            color: Colors.grey[400],
          ),
          child: ListTile(
            title: Text(
              floor.name,
              style: Theme.of(context).textTheme.titleMedium,
            ),
            trailing: IconButton(
              onPressed: () => context.read<AddBuildingCubit>().removeFloor(indexFloor),
              icon: const Icon(Icons.delete),
            ),
            onLongPress: () async {
              final AddBuildingCubit bloc = context.read<AddBuildingCubit>();
              final String res = await editFieldModal(context, floor.name);

              if (res.isNotEmpty) {
                bloc.updateFloor(floor.copyWith(name: res), indexFloor);
              }
            },
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            ...floor.rooms.asMap().entries.map((MapEntry<int, RoomModel> e) {
              final int indexRoom = e.key;
              final RoomModel room = e.value;

              return Container(
                margin: const EdgeInsets.all(4.0),
                child: InkWell(
                  child: RawChip(
                    onDeleted: () => context.read<AddBuildingCubit>().removeRoom(indexFloor, indexRoom),
                    label: Text(room.name),
                  ),
                  onLongPress: () async {
                    final AddBuildingCubit bloc = context.read<AddBuildingCubit>();
                    final String res = await editFieldModal(context, room.name);

                    if (res.isNotEmpty) {
                      bloc.updateRoom(indexFloor, indexRoom, room.copyWith(name: res));
                    }
                  },
                ),
              );
            }),
            IconButton(
              onPressed: () => context.read<AddBuildingCubit>().addRoom(indexFloor),
              icon: const Icon(Icons.add),
            )
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}

Future<String> editFieldModal(BuildContext context, String value) async {
  return await showDialog(
        context: context,
        builder: (BuildContext ctx) {
          final TextEditingController controller = TextEditingController(text: value);
          return AlertDialog(
            title: Text('Edita: $value'),
            content: TextField(
              controller: controller,
              autofocus: true,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: value,
              ),
              onSubmitted: (String value) => Navigator.of(ctx).pop(value),
            ),
            actions: <Widget>[
              ElevatedButton(
                onPressed: () => Navigator.of(ctx).pop(controller.text),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                child: const Text('Aceptar'),
              ),
              ElevatedButton(onPressed: () => Navigator.of(ctx).pop(null), child: const Text('Cancelar')),
            ],
          );
        },
      ) ??
      '';
}
