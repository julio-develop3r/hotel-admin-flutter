import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import 'bloc/operations_bloc.dart';

class OperationsScreen extends StatelessWidget {
  const OperationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<OperationsBloc>(
      create: (_) => OperationsBloc()..add(FetchBuildings()),
      child: const _View(),
    );
  }
}

class _View extends StatelessWidget {
  const _View();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<OperationsBloc, OperationsState>(
      builder: (BuildContext context, OperationsState state) {
        if (state is! OperationsLoaded) {
          return const Center(child: CircularProgressIndicator());
        }

        return ListView.builder(
          itemCount: state.buildings.length,
          itemBuilder: (_, int index) => ListTile(
            leading: const Icon(Icons.apartment),
            title: Text(state.buildings[index].name),
            subtitle: Text('Pisos ${state.buildings[index].floors.length}'),
            onTap: () => context.push('/operations/floor', extra: state.buildings[index]),
          ),
        );
      },
    );
  }
}
