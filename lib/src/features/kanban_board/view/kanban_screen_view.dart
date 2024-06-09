import 'package:appflowy_board/appflowy_board.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kanban_flutter/src/core/utils/bottomsheet_utils.dart';
import 'package:kanban_flutter/src/features/kanban_board/bloc/kanban_bloc.dart';
import 'package:kanban_flutter/src/features/kanban_board/bloc/kanban_event.dart';
import 'package:kanban_flutter/src/features/kanban_board/bloc/kanban_state.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/core/extensions/scaffold_extension.dart';
import 'package:kanban_flutter/src/core/widgets/text_widgets/text_Widgets.dart';
import 'package:kanban_flutter/src/features/kanban_board/model/kanban_model.dart';
import 'package:kanban_flutter/src/features/kanban_board/widgets/kanban_add_update_view.dart';
import 'package:kanban_flutter/src/features/kanban_board/widgets/kanban_card_item_view.dart';

///KanbanScreenView - Display Kanban Board View
class KanbanScreenView extends StatefulWidget {
  const KanbanScreenView({super.key});

  @override
  State<KanbanScreenView> createState() => _KanbanScreenViewState();
}

class _KanbanScreenViewState extends State<KanbanScreenView> {
  late AppFlowyBoardScrollController boardController;

  @override
  void initState() {
    super.initState();
    boardController = AppFlowyBoardScrollController();
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KanbanBloc, KanbanState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state is KanbanLoaded) {
          return Column(
            children: [
              const SizedBox(height: 10),

              ///KanbanBoard View
              AppFlowyBoard(
                config: state.config,
                controller: state.controller,
                boardScrollController: boardController,
                groupConstraints: const BoxConstraints.tightFor(width: 240),
                cardBuilder: (context, group, groupItem) {
                  return AppFlowyGroupCard(
                    key: ValueKey(groupItem.id),
                    child: KanbanCardItemView(
                      groupId: group.id,
                      item: groupItem,
                      controller: state.controller,
                    ),
                  );
                },
                headerBuilder: (context, columnData) {
                  return AppFlowyGroupHeader(
                    title: Text(columnData.headerData.groupName),
                    addIcon: const Icon(Icons.add, size: 20),
                    onAddButtonClick: () {
                      BottomSheetUtils.bottomSheet(
                          context: context,
                          widgetBuilder: (context) {
                            return BlocProvider(
                              create: (context) => KanbanBloc(),
                              child: KanbanAddUpdateView(
                                isAdd: true,
                                data: KanbanDataModel(groupId: columnData.id),
                                onTapCallBack: (value) {
                                  context.read<KanbanBloc>().add(
                                        KanbanAddTask(
                                          groupId: columnData.id,
                                          title: value.title ?? '',
                                          description: value.description ?? '',
                                        ),
                                      );
                                },
                              ),
                            );
                          }).then((value) {
                        boardController.scrollToBottom(columnData.id);
                      });
                    },
                    height: 50,
                    margin: state.config.groupBodyPadding,
                  );
                },
                footerBuilder: (context, group) {
                  return AppFlowyGroupFooter(
                    icon: const Icon(Icons.add, size: 20),
                    title: const TextWidgets(
                      text: StringConstants.addTask,
                      style: TextStyle(),
                    ),
                    height: 50,
                    margin: state.config.groupBodyPadding,
                    onAddButtonClick: () {
                      BottomSheetUtils.bottomSheet(
                          context: context,
                          widgetBuilder: (ctx) {
                            return BlocProvider(
                              create: (context) => KanbanBloc(),
                              child: KanbanAddUpdateView(
                                isAdd: true,
                                data: KanbanDataModel(groupId: group.id),
                                onTapCallBack: (value) {
                                  context.read<KanbanBloc>().add(
                                        KanbanAddTask(
                                          groupId: group.id,
                                          title: value.title ?? '',
                                          description: value.description ?? '',
                                        ),
                                      );
                                },
                              ),
                            );
                          }).then((value) {
                        boardController.scrollToBottom(group.id);
                      });
                    },
                  );
                },
              ),
            ],
          );
        }

        return const SizedBox();
      },
    ).baseScaffold(
        appBar: AppBar(
      title: const TextWidgets(
        text: StringConstants.appName,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
      ),
    ));
  }
}
