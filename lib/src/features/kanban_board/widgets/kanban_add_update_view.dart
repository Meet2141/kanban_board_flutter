import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/core/extensions/scaffold_extension.dart';
import 'package:kanban_flutter/src/core/extensions/validation_extension.dart';
import 'package:kanban_flutter/src/core/utils/app_utils.dart';
import 'package:kanban_flutter/src/core/utils/progress_loader_utils.dart';
import 'package:kanban_flutter/src/core/widgets/app_textfield/app_textfield_widgets.dart';
import 'package:kanban_flutter/src/core/widgets/buttons/row_button_widget.dart';
import 'package:kanban_flutter/src/core/widgets/text_widgets/bottomsheet_header_text_widgets.dart';
import 'package:kanban_flutter/src/features/kanban_board/model/kanban_model.dart';
import 'package:kanban_flutter/src/features/kanban_board/widgets/kanban_add_update_date_widget.dart';
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
  ValueNotifier<bool> isEnable = ValueNotifier(false);
  final TextEditingController titleController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  DateTime? startDate;
  DateTime? endDate;

  @override
  void initState() {
    super.initState();
    AppUtils.futureDelay(
        duration: const Duration(milliseconds: 500),
        afterDelay: () {
          initialData();
        });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      formKey.currentState?.validate();
    });
  }

  void initialData() {
    titleController.text = widget.data.title ?? '';
    descriptionController.text = widget.data.description ?? '';
    startDate = widget.data.startDate;
    endDate = widget.data.endDate;
    isEnable.value = formKey.currentState?.validate() ?? false;
  }

  @override
  void dispose() {
    super.dispose();
    titleController.dispose();
    descriptionController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: isEnable,
      builder: (context, isEnableBool, child) {
        return FractionallySizedBox(
          heightFactor: 0.8,
          widthFactor: 1,
          child: Form(
            key: formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ///Header and Close Button
                BottomSheetHeaderTextWidgets(
                  header: widget.isAdd ? translation(context).addTask : translation(context).updateTask,
                  onBack: () {},
                ),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      ///Title
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

                      ///Description
                      AppTextField(
                        controller: descriptionController,
                        maxLines: 4,
                        hintText: translation(context).description,
                        onChange: (value) {
                          enable();
                        },
                        validate: (value) {
                          return value.toString().validDescription(context: context, ignoreEmpty: true);
                        },
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          ///Start Date Picker
                          KanbanAddUpdateDateWidget(
                            header: translation(context).startDate,
                            value: startDate != null ? startDate.toString() : '',
                            onTap: () async {
                              await appState.selectDate(context).then((value) {
                                startDate = value;
                                setState(() {});
                              });
                            },
                          ),

                          ///End Date Picker
                          KanbanAddUpdateDateWidget(
                            header: translation(context).endDate,
                            value: endDate != null ? endDate.toString() : '',
                            onTap: () async {
                              await appState.selectDate(context).then((value) {
                                endDate = value;
                                setState(() {});
                              });
                            },
                          ),
                        ],
                      ).bodyPadding(width: 4),
                    ],
                  ),
                ),

                ///Cancel & Add/Update Button
                RowButtonWidgets(
                  isValidNext: isEnableBool,
                  cancelBtnName: translation(context).cancel,
                  nxtBtnName: widget.isAdd ? translation(context).add : translation(context).update,
                  nextTap: () async {
                    if (isEnableBool) {
                      LoaderUtils.showProgressDialog(context);
                      AppUtils.futureDelay(
                          seconds: 1,
                          afterDelay: () {
                            widget.onTapCallBack.call(
                              KanbanDataModel(
                                groupId: widget.data.groupId ?? '',
                                itemId: widget.data.itemId ?? '',
                                title: titleController.text,
                                description: descriptionController.text,
                                createdDate: widget.isAdd ? DateTime.now() : widget.data.createdDate,
                                updatedDate: !widget.isAdd ? DateTime.now() : widget.data.updatedDate,
                                startDate: startDate,
                                endDate: endDate,
                              ),
                            );
                            context.pop();
                            LoaderUtils.dismissProgressDialog(context);
                          });
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
      },
    );
  }

  ///enable - Enables Add/Update Button
  bool enable() {
    isEnable.value = (formKey.currentState?.validate() ?? false) && titleController.text.length > 2;
    return isEnable.value;
  }
}
