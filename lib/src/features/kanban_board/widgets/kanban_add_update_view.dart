import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_flutter/src/core/extensions/scaffold_extension.dart';
import 'package:kanban_flutter/src/core/extensions/validation_extension.dart';
import 'package:kanban_flutter/src/core/widgets/app_textfield/app_textfield_widgets.dart';
import 'package:kanban_flutter/src/core/widgets/buttons/row_button_widget.dart';
import 'package:kanban_flutter/src/core/widgets/text_widgets/bottomsheet_header_text_widgets.dart';
import 'package:kanban_flutter/src/features/kanban_board/model/kanban_model.dart';
import 'package:kanban_flutter/src/localization/language_constants.dart';

///KanbanAddUpdateView - Display Kanban Add/Update View for Card
class KanbanAddUpdateView extends StatefulWidget {
  final bool isAdd;
  final KanbanDataModel data;
  final Function(KanbanDataModel) onTapCallBack;

  const KanbanAddUpdateView({
    super.key,
    required this.isAdd,
    required this.data,
    required this.onTapCallBack,
  });

  @override
  State<KanbanAddUpdateView> createState() => _KanbanAddUpdateViewState();
}

class _KanbanAddUpdateViewState extends State<KanbanAddUpdateView> {
  final formKey = GlobalKey<FormState>();
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  void initState() {
    super.initState();
    initialData();
  }

  void initialData() {
    if ((widget.data.itemId ?? '').isNotEmpty) {
      titleController.text = widget.data.title ?? '';
      descriptionController.text = widget.data.description ?? '';
      setState(() {});
    }
  }

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      heightFactor: 0.8,
      widthFactor: 1,
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            BottomSheetHeaderTextWidgets(
              header: widget.isAdd ? translation(context).addTask : translation(context).updateTask,
              onBack: () {},
            ),
            Expanded(
              child: Column(
                children: [
                  AppTextField(
                    controller: titleController,
                    hintText: translation(context).title,
                    mandatory: true,
                    mandatoryText: '*',
                    onChange: (value) {
                      enable();
                    },
                    validate: (value) {
                      return value.toString().validTitle(context: context, ignoreEmpty: true);
                    },
                  ),
                  const SizedBox(height: 12),
                  AppTextField(
                    controller: descriptionController,
                    hintText: translation(context).description,
                    onChange: (value) {
                      enable();
                    },
                    validate: (value) {
                      return value.toString().validDescription(context: context, ignoreEmpty: true);
                    },
                  ),
                ],
              ),
            ),
            RowButtonWidgets(
              isValidNext: enable(),
              cancelBtnName: translation(context).cancel,
              nxtBtnName: widget.isAdd ? translation(context).add : translation(context).update,
              // nxtBtnName: translation(context).,
              nextTap: () {
                if (enable()) {
                  widget.onTapCallBack.call(
                    KanbanDataModel(
                      groupId: widget.data.groupId ?? '',
                      itemId: widget.data.itemId ?? '',
                      title: titleController.text,
                      description: descriptionController.text,
                    ),
                  );
                  context.pop();
                }
              },
              cancelTap: () {
                context.pop();
              },
            ),
            SizedBox(height: MediaQuery.paddingOf(context).bottom + MediaQuery.viewInsetsOf(context).bottom + 10),
          ],
        ),
      ).bodyPadding(),
    );
  }

  bool enable() {
    bool isEnable = (formKey.currentState?.validate() ?? false) && titleController.text.length > 2;
    setState(() {});
    return isEnable;
  }
}
