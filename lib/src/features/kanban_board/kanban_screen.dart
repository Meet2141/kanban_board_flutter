import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seed_flutter/src/features/kanban_board/bloc/kanban_bloc.dart';
import 'package:seed_flutter/src/features/kanban_board/bloc/kanban_event.dart';
import 'package:seed_flutter/src/features/kanban_board/view/kanban_screen_view.dart';

///KanbanScreen - Display Kanban Screen
class KanbanScreen extends StatelessWidget {
  const KanbanScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => KanbanBloc()..add(KanbanInitialLoadEvent()),
      child: const KanbanScreenView(),
    );
  }
}
