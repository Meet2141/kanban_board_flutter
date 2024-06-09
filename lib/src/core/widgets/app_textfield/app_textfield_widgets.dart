import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:seed_flutter/src/core/constants/color_constants.dart';
import 'package:seed_flutter/src/core/widgets/text_widgets/text_Widgets.dart';

/// AppTextField is common textField used in app.
class AppTextField extends StatelessWidget {
  final Color? color;
  final double? fontSize;
  final int? maxLines;
  final VoidCallback? onTap;
  final ValueChanged<String>? onChange;
  final FormFieldValidator<String>? validate;
  final TextInputType keyboardType;
  final int? maxLength;
  final TextInputAction? textInputAction;
  final TextCapitalization textCapitalization;
  final Color? focusColorBorder;
  final TextEditingController? controller;
  final bool isEnabled;
  final Widget? prefixIcon;
  final Widget? prefix;
  final Widget? suffix;
  final Widget? suffixIcon;
  final String? hintText;
  final bool autoValidate;
  final TextStyle? errorStyle;
  final FocusNode? focusNode;
  final String? mandatoryText;
  final bool mandatory;
  final bool isScrollPadding;
  final bool alignHintLabel;
  final bool autoFocus;
  final List<TextInputFormatter>? inputFormatter;
  final String? initialValue;
  final BorderRadius? borderRadius;
  final bool showLabel;
  final OutlineInputBorder? focusedBorder;
  final OutlineInputBorder? disabledBorder;
  final OutlineInputBorder? enabledBorder;
  final OutlineInputBorder? focusedErrorBorder;
  final OutlineInputBorder? errorBorder;

  const AppTextField({
    super.key,
    this.color,
    this.alignHintLabel = true,
    this.fontSize,
    this.isScrollPadding = false,
    this.mandatory = false,
    this.autoFocus = false,
    this.mandatoryText,
    this.maxLines,
    this.suffix,
    this.onTap,
    this.onChange,
    this.validate,
    this.keyboardType = TextInputType.text,
    this.maxLength,
    this.textInputAction,
    this.textCapitalization = TextCapitalization.none,
    this.focusColorBorder,
    this.controller,
    this.isEnabled = true,
    this.prefixIcon,
    this.prefix,
    this.hintText,
    this.inputFormatter,
    this.autoValidate = true,
    this.focusNode,
    this.errorStyle,
    this.initialValue,
    this.borderRadius,
    this.showLabel = true,
    this.suffixIcon,
    this.focusedBorder,
    this.disabledBorder,
    this.enabledBorder,
    this.focusedErrorBorder,
    this.errorBorder,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      autofocus: autoFocus,
      initialValue: initialValue,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      controller: controller,
      maxLines: maxLines ?? 1,
      onTap: onTap,
      cursorColor: ColorConstants.black,
      focusNode: focusNode,
      scrollPadding:
          isScrollPadding ? EdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom + 100) : EdgeInsets.zero,
      inputFormatters: inputFormatter,
      onChanged: (value) {
        if (onChange != null) {
          onChange!(value);
        }
      },
      autovalidateMode: autoValidate ? AutovalidateMode.onUserInteraction : AutovalidateMode.disabled,
      validator: validate,
      maxLength: maxLength,
      keyboardType: keyboardType,
      enabled: isEnabled,
      maxLengthEnforcement: MaxLengthEnforcement.enforced,
      style: TextStyle(
        fontSize: fontSize ?? 14,
        color: color ?? (isEnabled ? ColorConstants.black : ColorConstants.border),
      ),
      decoration: InputDecoration(
        counterText: '',
        hintText: hintText,
        labelStyle: const TextStyle(fontSize: 12, color: ColorConstants.border),
        hintStyle: const TextStyle(fontSize: 12, color: ColorConstants.border),
        label: (showLabel)
            ? Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if ((hintText ?? '').isNotEmpty)
                    TextWidgets(
                      text: hintText ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: isEnabled ? ColorConstants.black : ColorConstants.divider,
                      ),
                    ),
                  if (mandatory)
                    TextWidgets(
                      text: mandatoryText ?? '',
                      style: TextStyle(
                        fontSize: 12,
                        color: mandatory
                            ? ColorConstants.red
                            : isEnabled
                                ? ColorConstants.black
                                : ColorConstants.divider,
                      ),
                    ),
                ],
              )
            : const SizedBox.shrink(),
        alignLabelWithHint: alignHintLabel,
        filled: true,
        isDense: true,
        fillColor: ColorConstants.white,
        prefixIcon: prefixIcon,
        prefix: prefix,
        suffix: suffix,
        suffixIcon: suffixIcon,
        errorMaxLines: 2,
        errorStyle: errorStyle ?? const TextStyle(fontSize: 10, color: ColorConstants.red, height: 1),
        contentPadding: EdgeInsets.only(left: 14.0, bottom: maxLength == null ? 12.0 : 26.0, top: 12.0, right: 15),
        focusedBorder: focusedBorder ??
            OutlineInputBorder(
              borderSide: BorderSide(color: focusColorBorder ?? ColorConstants.black, width: 1),
              borderRadius: borderRadius ?? BorderRadius.circular(10),
            ),
        disabledBorder: disabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.border, width: 1),
              borderRadius: borderRadius ?? BorderRadius.circular(10),
            ),
        enabledBorder: enabledBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.border, width: 1),
              borderRadius: borderRadius ?? BorderRadius.circular(10),
            ),
        focusedErrorBorder: focusedErrorBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.red, width: 1.5),
              borderRadius: borderRadius ?? BorderRadius.circular(10),
            ),
        errorBorder: errorBorder ??
            OutlineInputBorder(
              borderSide: const BorderSide(color: ColorConstants.red, width: 1),
              borderRadius: borderRadius ?? BorderRadius.circular(10),
            ),
      ),
    );
  }
}
