import 'package:appflowy_board/appflowy_board.dart';
import 'package:equatable/equatable.dart';

abstract class KanbanState extends Equatable {
  @override
  List<Object> get props => [];
}

class KanbanInitial extends KanbanState {}

class KanbanLoaded extends KanbanState {
  final AppFlowyBoardController controller;
  final AppFlowyBoardConfig config;

  KanbanLoaded({required this.controller, required this.config});

  @override
  List<Object> get props => [controller, config];
}
