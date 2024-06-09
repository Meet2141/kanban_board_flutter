import 'package:flutter/material.dart';
import 'package:kanban_flutter/src/core/constants/color_constants.dart';

/// ScaffoldExtension class return scaffold widget with
/// fixed layout properties.
extension ScaffoldExtension on Widget {
  PopScope baseScaffold({
    bool? resizeToAvoidBottomInset,
    double? bodyPadding = 8,
    VoidCallback? onTap,
    PreferredSizeWidget? appBar,
  }) {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: ColorConstants.white,
          appBar: appBar,
          resizeToAvoidBottomInset: resizeToAvoidBottomInset,
          body: Column(
            children: [
              // Stack(
              //   children: [
              //     const BackGroundImageWidgets(height: 40),
              //     AppBarWidgets(
              //       title: title,
              //       onTap: onTap,
              //     ),
              //   ],
              // ),
              Expanded(
                child: this.bodyPadding(width: bodyPadding),
              )
            ],
          ),
        ));
  }

  PopScope baseScaffoldNoAppBar() {
    return PopScope(
        canPop: false,
        child: Scaffold(
          backgroundColor: ColorConstants.white,
          body: Column(
            children: [
              Expanded(
                child: Padding(
                  padding: const EdgeInsetsDirectional.only(start: 8, end: 8),
                  child: this,
                ),
              )
            ],
          ),
        ));
  }

  Widget bodyPaddingWithExpanded() {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: this,
      ),
    );
  }

  Widget bodyPadding({double? width}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: width ?? 8),
      child: this,
    );
  }

  Widget bodyPaddingSymmetric({double? horizontal, double? vertical}) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: horizontal ?? 8, vertical: vertical ?? 8),
      child: this,
    );
  }
}
