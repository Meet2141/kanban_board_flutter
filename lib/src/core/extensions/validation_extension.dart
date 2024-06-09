import 'package:kanban_flutter/src/core/constants/string_constants.dart';

extension ValidationExtension on String {
  ///Title
  String? validTitle({bool ignoreEmpty = false}) {
    if (isEmpty && ignoreEmpty) {
      return null;
    } else if (isEmpty) {
      return StringConstants.pleaseEnterTitle;
    } else if (trim().length < 2) {
      return StringConstants.titleMustHaveTwoCharacters;
    } else {
      return null;
    }
  }

  ///Description
  String? validDescription({bool ignoreEmpty = false}) {
    if (isEmpty && ignoreEmpty) {
      return null;
    } else if (isEmpty) {
      return StringConstants.pleaseEnterDescription;
    } else if (trim().length < 2) {
      return StringConstants.descriptionMustHaveTwoCharacters;
    } else if (trim().length > 100) {
      return StringConstants.descriptionMustHaveTwoCharacters;
    } else {
      return null;
    }
  }
}
