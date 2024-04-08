import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../styles.dart';
import '../utils/common_sizes.dart';

class CustomTextField extends StatelessWidget {
  final TextEditingController controller;
  final TextInputAction textInputAction;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final String labelText;
  final FormFieldValidator<String>? validator;
  final ValueChanged<String> onFieldSubmitted;
  final ValueChanged<String> onChanged;
  final bool obscureText;
  final String hintText;
  final InputBorder? inputBorder;
  final InputBorder? errorBorder;
  final int minLines;
  final bool isPhone;
  final bool justLatinLetters;

  final int? maxLines;
  final double? height;
  final bool? enabled;
  final GlobalKey<FormFieldState<String>>? textKey;
  final bool? isRtl;
  final double? width;
  final TextAlign textAlign;
  final EdgeInsetsGeometry? contentPaddig;
  final BoxDecoration? decoration;
  final InputDecoration? inputDecoration;
  final TextStyle textStyle;
  final AutovalidateMode autoValidation;
  final Widget? suffixIcon;
  final Widget? prefixIcon;
  final InputBorder? borderFocus;

  CustomTextField(
      {Key? key,
      this.textKey,
      this.isRtl,
      this.width,
      this.isPhone = false,
      this.justLatinLetters = false,
      this.contentPaddig,
      required this.textStyle,
      this.inputBorder,
      this.errorBorder,
      required this.controller,
      this.borderFocus,
      required this.textInputAction,
      required this.keyboardType,
      this.focusNode,
      this.autoValidation = AutovalidateMode.disabled,
      this.labelText = "",
      this.validator,
      required this.onFieldSubmitted,
      required this.onChanged,
      this.obscureText = false,
      required this.hintText,
      this.inputDecoration,
      required this.minLines,
      this.maxLines,
      this.suffixIcon,
      this.prefixIcon,
      this.height,
      this.decoration,
      this.enabled = true,
      required this.textAlign})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    var border = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        borderSide: BorderSide(color: Styles.colorBorderTextField));
    var focusborder = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        borderSide: BorderSide(color: Styles.colorPrimary));

    var errorBord = OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(12.r)),
        borderSide: BorderSide(color: Colors.red));
    return Container(
        alignment: Alignment.center,
        height: textKey?.currentState == null
            ? height
            : textKey?.currentState!.errorText == null
                ? height
                : height! * 1.5,
        width: width,
        child: Center(
          child: TextFormField(
            maxLines: maxLines,
            enabled: enabled,
            key: textKey,
            textAlign: textAlign,
            toolbarOptions: ToolbarOptions(
                copy: true, paste: true, cut: true, selectAll: true),
            textAlignVertical: TextAlignVertical.center,
            textDirection:
                (isRtl ?? true) ? TextDirection.ltr : TextDirection.rtl,
            autocorrect: false,
            style: textStyle,
            controller: controller,
            textInputAction: textInputAction,
            keyboardType: keyboardType,
            focusNode: focusNode,
            decoration: inputDecoration ??
                InputDecoration(
                    // filled: true,
                    labelText: hintText,
                    errorMaxLines: 1,
                    errorText: textKey?.currentState == null
                        ? null
                        : textKey?.currentState!.errorText == null
                            ? null
                            : textKey?.currentState!.errorText!.compareTo('') ==
                                    0
                                ? null
                                : textKey?.currentState!.errorText,
                    labelStyle: Styles.w400TextStyle().copyWith(
                      fontSize: 14.sp,
                      color: textKey?.currentState == null
                          ? Styles.colorTextTextField
                          : textKey?.currentState!.errorText == null
                              ? Styles.colorTextTextField
                              : Styles.colorTextError,
                    ),
                    errorStyle: Styles.w400TextStyle().copyWith(
                      fontSize: 12.sp,
                      color: Styles.colorTextError,
                    ),
                    fillColor: Styles.colorBackgroundContanier,
                    hintStyle: textStyle,
                    border: inputBorder ?? border,
                    errorBorder: errorBorder ?? errorBord,
                    enabledBorder: inputBorder ?? border,
                    // focusedBorder: inputBorder??borderFocus,
                    focusedBorder: borderFocus ?? focusborder,
                    // helperStyle: TextStyle(fontSize: Styles.fontSize25),

                    contentPadding: contentPaddig ??
                        EdgeInsetsDirectional.only(
                            start: CommonSizes.TINY_LAYOUT_W_GAP,
                            end: CommonSizes.TINY_LAYOUT_W_GAP,
                            top: 0,
                            bottom: 0),
                    focusedErrorBorder: inputBorder,
                    hintText: hintText,
                    suffixIcon: suffixIcon,
                    prefixIcon: prefixIcon),
            validator: validator,
            onFieldSubmitted: onFieldSubmitted,
            onChanged: onChanged,
            obscureText: obscureText,
          ),
        ));
  }
}
