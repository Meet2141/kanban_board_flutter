import 'package:flutter/material.dart';
import 'package:kanban_flutter/src/core/constants/string_constants.dart';
import 'package:kanban_flutter/src/core/extensions/gesture_extensions.dart';
import 'package:kanban_flutter/src/core/widgets/text_widgets/text_widgets.dart';

///KanbanAddUpdateDateWidget - Display Date Picker View for Add/Update Task
class KanbanAddUpdateDateWidget extends StatelessWidget {
  final String header;
  final String value;
  final VoidCallback onTap;

  const KanbanAddUpdateDateWidget({
    super.key,
    required this.header,
    required this.value,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.calendar_month, size: 12),
              const SizedBox(width: 5),
              TextWidgets(
                text: header,
                style: const TextStyle(
                  fontSize: 12,
                ),
              ),
            ],
          ),
          TextWidgets(
            text: value.isNotEmpty ? appState.formatDateTime(dateTime: value) : '-',
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ).onPressedWithoutHaptic(onTap),
    );
  }
}
