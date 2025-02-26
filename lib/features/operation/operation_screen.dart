import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locks_flutter/features/room/room_screen.dart';
import 'package:locks_flutter/models/building_model.dart';
import 'package:locks_flutter/models/event_room_model.dart';
import 'package:locks_flutter/models/floor_model.dart';
import 'package:locks_flutter/models/room_model.dart';
import 'package:locks_flutter/shared/consts.dart';

import 'bloc/operation_bloc.dart';

class OperationScreen extends StatelessWidget {
  const OperationScreen({required this.building, super.key});

  final BuildingModel building;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OperationBloc>(
      create: (_) => OperationBloc(building.idBuilding!),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationBloc, OperationState>(
      builder: (_, OperationState state) {
        if (state is! OperationLoaded) {
          return Scaffold(appBar: AppBar(), body: const Center(child: CircularProgressIndicator()));
        }

        return Scaffold(
          appBar: AppBar(
            title: Text('${state.building.name} - (${state.building.percentageCompleted()}%)'),
          ),
          body: ListView.builder(
            shrinkWrap: true,
            itemCount: state.building.floors.length,
            itemBuilder: (_, int index) => _FloorWidget(state.building.floors[index], index),
          ),
        );
      },
    );
  }
}

class _FloorWidget extends StatelessWidget {
  const _FloorWidget(this.floor, this.index);

  final FloorModel floor;
  final int index;

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
          ),
        ),
        Wrap(
          alignment: WrapAlignment.start,
          children: <Widget>[
            ...floor.rooms.asMap().entries.map(
              (MapEntry<int, RoomModel> e) {
                final RoomModel room = e.value;

                return Container(
                  margin: const EdgeInsets.all(4.0),
                  child: RawChip(
                    label: Column(
                      children: <Widget>[
                        Row(
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            if (room.events
                                .any((EventRoomModel element) => element.comment?.isNotEmpty ?? false)) ...<Widget>[
                              const Icon(
                                Icons.comment_outlined,
                                color: Colors.white,
                              ),
                              const SizedBox(width: 4),
                            ],
                            Text(room.name),
                          ],
                        ),
                        Text(room.status, style: Theme.of(context).textTheme.labelSmall),
                      ],
                    ),
                    backgroundColor: colorStatus[room.status],
                    onPressed: () => Navigator.push(
                      context,
                      MaterialPageRoute<OperationScreen>(
                        builder: (_) => RoomScreen(
                          room: room,
                          onUpdateRoom: (RoomModel room, String prevState, String comment) {
                            context.read<OperationBloc>().add(UpdateRoom(index, room, e.key, prevState, comment));
                          },
                        ),
                      ),
                    ),
                  ),
                );
              },
            )
          ],
        ),
        const SizedBox(height: 8),
      ],
    );
  }
}
