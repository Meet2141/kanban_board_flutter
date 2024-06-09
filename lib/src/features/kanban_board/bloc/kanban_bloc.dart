import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:seed_flutter/src/core/constants/color_constants.dart';
import 'package:seed_flutter/src/features/kanban_board/bloc/kanban_event.dart';
import 'package:seed_flutter/src/features/kanban_board/bloc/kanban_state.dart';
import 'package:seed_flutter/src/features/kanban_board/widgets/kanban_card_item_view.dart';
import 'package:uuid/uuid.dart';

enum KanbanType { backlog, inProgress, done }

class KanbanBloc extends Bloc<KanbanEvent, KanbanState> {
  final AppFlowyBoardController controller = AppFlowyBoardController(
    onMoveGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      // debugPrint('Move item from $fromIndex to $toIndex');
    },
    onMoveGroupItem: (groupId, fromIndex, toIndex) {
      // debugPrint('Move $groupId:$fromIndex to $groupId:$toIndex');
    },
    onMoveGroupItemToGroup: (fromGroupId, fromIndex, toGroupId, toIndex) {
      // debugPrint('Move $fromGroupId:$fromIndex to $toGroupId:$toIndex');
    },
  );

  final config = AppFlowyBoardConfig(
    groupBackgroundColor: HexColor.fromHex('#F7F8FC'),
    stretchGroupHeight: false,
  );

  KanbanBloc() : super(KanbanInitial()) {
    on<KanbanInitialLoadEvent>(_onKanbanInitialLoad);
    on<KanbanAddTask>(_onKanbanAddTask);
    on<KanbanUpdateTask>(_onKanbanUpdateTask);
    on<KanbanDeleteTask>(_onKanbanDeleteTask);
  }

  void _onKanbanInitialLoad(KanbanInitialLoadEvent event, Emitter<KanbanState> emit) {
    final group1 = AppFlowyGroupData(
      id: KanbanType.backlog.name,
      name: 'Backlog',
      items: [],
    );

    final group2 = AppFlowyGroupData(
      id: KanbanType.inProgress.name,
      name: 'In Progress',
      items: [],
    );

    final group3 = AppFlowyGroupData(id: KanbanType.done.name, name: 'Done', items: []);

    controller.addGroup(group1);
    controller.addGroup(group2);
    controller.addGroup(group3);
    emit(KanbanLoaded(controller: controller, config: config));
  }

  void _onKanbanAddTask(KanbanAddTask event, Emitter<KanbanState> emit) {
    if (state is KanbanLoaded) {
      controller.addGroupItem(
        event.groupId,
        KanbanCardItemDataModel(
          itemId: const Uuid().v4(),
          title: event.title,
          description: event.description,
        ),
      );
      emit(KanbanLoaded(controller: controller, config: config));
    }
  }

  void _onKanbanUpdateTask(KanbanUpdateTask event, Emitter<KanbanState> emit) {
    if (state is KanbanLoaded) {
      controller.updateGroupItem(
        event.groupId,
        KanbanCardItemDataModel(
          itemId: event.itemId,
          title: event.title,
          description: event.description,
        ),
      );
      emit(KanbanLoaded(controller: controller, config: config));
    }
  }

  void _onKanbanDeleteTask(KanbanDeleteTask event, Emitter<KanbanState> emit) {
    if (state is KanbanLoaded) {
      controller.removeGroupItem(event.groupId, event.itemId);
      emit(KanbanLoaded(controller: controller, config: config));
    }
  }
}
