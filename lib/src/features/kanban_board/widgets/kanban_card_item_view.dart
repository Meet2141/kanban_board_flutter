import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/src/core/constants/color_constants.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/core/extensions/gesture_extensions.dart';
import 'package:kanban_flutter/src/core/utils/bottomsheet_utils.dart';
import 'package:kanban_flutter/src/features/kanban_board/bloc/kanban_bloc.dart';
import 'package:kanban_flutter/src/features/kanban_board/bloc/kanban_event.dart';
import 'package:kanban_flutter/src/features/kanban_board/model/kanban_model.dart';
import 'package:kanban_flutter/src/features/kanban_board/widgets/kanban_add_update_view.dart';

///KanbanCardItemView - Display Kanban Card View in Kanban Board
class KanbanCardItemView extends StatelessWidget {
  final String groupId;
  final AppFlowyGroupItem item;
  final AppFlowyBoardController controller;

  const KanbanCardItemView({
    super.key,
    required this.groupId,
    required this.item,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return kanbanCardItemView(context, item: item, controller: controller);
  }

  ///kanbanCardItemView - Card Item View in Kanban Card
  Widget kanbanCardItemView(
    BuildContext context, {
    required AppFlowyGroupItem item,
    required AppFlowyBoardController controller,
  }) {
    if (item is KanbanCardItemDataModel) {
      return DecoratedBox(
        decoration: BoxDecoration(borderRadius: BorderRadius.circular(12)),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      item.title,
                      style: const TextStyle(fontSize: 14),
                      textAlign: TextAlign.left,
                    ),
                    if (item.description.isNotEmpty)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Text(
                          item.description,
                          style: const TextStyle(fontSize: 12, color: Colors.grey),
                        ),
                      ),
                    if (item.startDate != null)
                      Padding(
                        padding: const EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            Text(
                              appState.formatDateTime(dateTime: item.startDate.toString()),
                              style: const TextStyle(fontSize: 12, color: Colors.grey),
                            ),
                            if (item.endDate != null)
                              Text(
                                '- ${appState.formatDateTime(dateTime: item.endDate.toString())}',
                                style: const TextStyle(fontSize: 12, color: Colors.grey),
                              )
                          ],
                        ),
                      ),
                  ],
                ),
              ),
              const Icon(
                Icons.delete_outline,
                color: ColorConstants.red,
                size: 20,
              ).onPressedWithHaptic(() {
                context.read<KanbanBloc>().add(
                      KanbanDeleteTask(
                        groupId: groupId,
                        itemId: item.itemId,
                      ),
                    );
              })
            ],
          ),
        ),
      ).onPressedWithHaptic(() {
        BottomSheetUtils.bottomSheet(
            context: context,
            widgetBuilder: (ctx) {
              return BlocProvider(
                create: (context) => KanbanBloc(),
                child: KanbanAddUpdateView(
                  isAdd: false,
                  data: KanbanDataModel(
                      groupId: groupId,
                      itemId: item.itemId,
                      title: item.title,
                      description: item.description,
                      startDate: item.startDate,
                      endDate: item.endDate),
                  onTapCallBack: (value) {
                    context.read<KanbanBloc>().add(
                          KanbanUpdateTask(
                            groupId: groupId,
                            itemId: item.itemId,
                            data: value,
                          ),
                        );
                  },
                ),
              );
            });
      });
    }
    throw UnimplementedError();
  }
}

///KanbanCardItem - Display Kanban Card Item View
class KanbanCardItemDataModel extends AppFlowyGroupItem {
  final String itemId;
  final String title;
  final String description;
  final DateTime? startDate;
  final DateTime? endDate;
  final DateTime? createdDate;
  final DateTime? updatedDate;

  KanbanCardItemDataModel({
    required this.itemId,
    required this.title,
    required this.description,
    this.startDate,
    this.endDate,
    this.createdDate,
    this.updatedDate,
  });

  @override
  String get id => itemId;
}
