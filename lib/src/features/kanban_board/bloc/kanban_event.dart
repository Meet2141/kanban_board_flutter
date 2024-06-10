import 'package:equatable/equatable.dart';
import 'package:kanban_flutter/src/features/kanban_board/model/kanban_model.dart';

abstract class KanbanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class KanbanInitialLoadEvent extends KanbanEvent {}

class KanbanAddTask extends KanbanEvent {
  final String groupId;
  final KanbanDataModel data;

  KanbanAddTask({
    required this.groupId,
    required this.data,
  });

  @override
  List<Object> get props => [groupId, data];
}

class KanbanUpdateTask extends KanbanEvent {
  final String groupId;
  final String itemId;
  final KanbanDataModel data;

  KanbanUpdateTask({
    required this.groupId,
    required this.itemId,
    required this.data,
  });

  @override
  List<Object> get props => [groupId, itemId, data];
}

class KanbanDeleteTask extends KanbanEvent {
  final String groupId;
  final String itemId;

  KanbanDeleteTask({
    required this.groupId,
    required this.itemId,
  });

  @override
  List<Object> get props => [groupId, itemId];
}
