import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:locks_flutter/models/event_room_model.dart';
import 'package:locks_flutter/models/room_model.dart';
import 'package:locks_flutter/shared/consts.dart';

import 'bloc/room_bloc.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({
    required this.room,
    required this.onUpdateRoom,
    super.key,
  });

  final RoomModel room;
  final Function(RoomModel room, String prevState, String comment) onUpdateRoom;

  @override
  Widget build(BuildContext context) {
    return BlocProvider<RoomBloc>(
      create: (_) => RoomBloc(room),
      child: _View(onUpdateRoom),
    );
  }
}

class _View extends StatelessWidget {
  const _View(this.onUpdateRoom);

  final Function(RoomModel room, String prevState, String comment) onUpdateRoom;

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RoomBloc, RoomState>(
      builder: (BuildContext context, RoomState state) {
        return Scaffold(
          appBar: AppBar(title: Text(state.room.name)),
          body: Column(
            children: <Widget>[
              Container(
                color: Colors.blueGrey[300],
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Flexible(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(
                          'Estado de la habitacion:',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                      ),
                    ),
                    DropdownButton<String>(
                      value: state.room.status,
                      items: const <DropdownMenuItem<String>>[
                        DropdownMenuItem<String>(
                          value: StatusTypes.available,
                          child: Text(StatusTypes.available),
                        ),
                        DropdownMenuItem<String>(
                          value: StatusTypes.notAvailable,
                          child: Text(StatusTypes.notAvailable),
                        ),
                        DropdownMenuItem<String>(
                          value: StatusTypes.salto,
                          child: Text(StatusTypes.salto),
                        ),
                        DropdownMenuItem<String>(
                          value: StatusTypes.inProgress,
                          child: Text(StatusTypes.inProgress),
                        ),
                        DropdownMenuItem<String>(
                          value: StatusTypes.priority,
                          child: Text(StatusTypes.priority),
                        ),
                      ],
                      onChanged: (String? value) {
                        context.read<RoomBloc>().add(UpdateRoom(state.room.copyWith(status: value!)));
                      },
                    ),
                  ],
                ),
              ),
              const _TextField(),
              Expanded(child: _EventsList(state.room.events)),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    onUpdateRoom(state.room, state.prevState, state.comment);
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(backgroundColor: Colors.green, foregroundColor: Colors.white),
                  child: const Text('Guardar'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _TextField extends StatefulWidget {
  const _TextField();

  @override
  State<_TextField> createState() => __TextFieldState();
}

class __TextFieldState extends State<_TextField> {
  final TextEditingController _commentController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: TextField(
        controller: _commentController,
        keyboardType: TextInputType.multiline,
        maxLines: 3,
        decoration: const InputDecoration(
          border: OutlineInputBorder(),
          labelText: 'Comentarios',
          hintText: 'Escribe algunos comentarios',
        ),
        onChanged: (String value) {
          context.read<RoomBloc>().add(UpdateComment(value));
        },
      ),
    );
  }
}

class _EventsList extends StatelessWidget {
  const _EventsList(this.events);

  final List<EventRoomModel> events;
  @override
  Widget build(BuildContext context) {
    if (events.isEmpty) {
      return const Center(child: Text('Aún no hay cambios en el cuarto'));
    }

    return Column(
      children: <Widget>[
        const SizedBox(height: 8),
        const Text('Eventos'),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListView.builder(
              itemCount: events.length,
              itemBuilder: (BuildContext context, int index) {
                final EventRoomModel item = events[index];

                return ListTile(
                  leading: Text('${index + 1}'),
                  title: Text(item.user),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Text(item.description),
                      Text(item.date.toLocal().toString()),
                      if (item.comment?.isNotEmpty ?? false)
                        Container(
                          decoration: BoxDecoration(color: Colors.grey[350]!, borderRadius: BorderRadius.circular(8)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text('Comentarios: ${item.comment}'),
                          ),
                        ),
                    ],
                  ),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}
