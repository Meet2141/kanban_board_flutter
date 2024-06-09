import 'package:equatable/equatable.dart';

abstract class KanbanEvent extends Equatable {
  @override
  List<Object> get props => [];
}

class KanbanInitialLoadEvent extends KanbanEvent {}

class KanbanAddTask extends KanbanEvent {
  final String groupId;
  final String title;
  final String description;

  KanbanAddTask({
    required this.groupId,
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [groupId];
}

class KanbanUpdateTask extends KanbanEvent {
  final String groupId;
  final String itemId;
  final String title;
  final String description;

  KanbanUpdateTask({
    required this.groupId,
    required this.itemId,
    required this.title,
    required this.description,
  });

  @override
  List<Object> get props => [groupId, itemId, title, description];
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
