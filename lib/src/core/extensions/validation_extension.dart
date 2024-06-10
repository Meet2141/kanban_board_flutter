import 'package:flutter/cupertino.dart';
import 'package:kanban_flutter/src/localization/language_constants.dart';

extension ValidationExtension on String {
  ///Title
  String? validTitle({required BuildContext context, bool ignoreEmpty = false}) {
    if (isEmpty && ignoreEmpty) {
      return null;
    } else if (isEmpty) {
      return translation(context).pleaseEnterTitle;
    } else if (trim().length < 2) {
      return translation(context).titleMustHaveTwoCharacters;
    } else {
      return null;
    }
  }

  ///Description
  String? validDescription({required BuildContext context, bool ignoreEmpty = false}) {
    if (isEmpty && ignoreEmpty) {
      return null;
    } else if (isEmpty) {
      return translation(context).pleaseEnterDescription;
    } else if (trim().length < 2) {
      return translation(context).descriptionMustHaveTwoCharacters;
    } else if (trim().length > 100) {
      return translation(context).descriptionMustHaveTwoCharacters;
    } else {
      return null;
    }
  }
}
