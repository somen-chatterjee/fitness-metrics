import 'package:fitness_metrics/ui/base_components/base_text.dart';
import 'package:fitness_metrics/utils/base_colors.dart';
import 'package:fitness_metrics/utils/base_functions.dart';
import 'package:flutter/material.dart';

class BaseButton extends StatelessWidget {
  final String title;
  final double? btnHeight, btnWidth;
  final double? borderRadius, fontSize;
  final double? bottomMargin, topMargin, rightMargin, leftMargin;
  final EdgeInsetsGeometry? padding;
  final Color? btnColor;
  final Color? borderColor;
  final Color? btnTextColor;
  final bool? enableHapticFeedback, hideKeyboard, borderEnable;
  final Widget? preFixIcon;
  final FontWeight? btnFontWeight;
  final void Function()? onPressed;

  const BaseButton({
    super.key,
    required this.title,
    this.btnHeight,
    this.btnWidth,
    this.btnColor,
    this.onPressed,
    this.bottomMargin,
    this.topMargin,
    this.rightMargin,
    this.leftMargin,
    this.enableHapticFeedback,
    this.hideKeyboard,
    this.padding,
    this.borderRadius,
    this.fontSize,
    this.btnTextColor,
    this.borderEnable = false,
    this.borderColor = Colors.white,
    this.preFixIcon,
    this.btnFontWeight,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          right: rightMargin ?? 0,
          left: leftMargin ?? 0,
          top: topMargin ?? 0,
          bottom: bottomMargin ?? 0),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: Size(btnWidth ?? double.infinity, btnHeight ?? 55),
          backgroundColor:
              !borderEnable! ? btnColor ?? BaseColors.primaryColor : btnColor,
          foregroundColor: btnColor ?? BaseColors.primaryColor,
          disabledBackgroundColor: btnColor ?? BaseColors.primaryColor,
          disabledForegroundColor: btnColor ?? BaseColors.primaryColor,
          elevation: 0,
          padding: padding,
          shape: RoundedRectangleBorder(
            side: borderEnable!
                ? BorderSide(color: borderColor ?? BaseColors.white, width: 1.0)
                : BorderSide.none,
            borderRadius: BorderRadius.circular(borderRadius ?? 10),
          ),
        ),
        onPressed: () {
          if (enableHapticFeedback ?? true) {
            triggerHapticFeedback();
          }
          if (hideKeyboard ?? true) {
            FocusManager.instance.primaryFocus?.unfocus();
          }
          if (onPressed != null) {
            onPressed!();
          }
        },
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            BaseText(
              value: title,
              color: btnTextColor ?? Colors.white,
              fontWeight: btnFontWeight ?? FontWeight.w500,
              fontSize: fontSize ?? 16,
            ),
            Visibility(
              visible: preFixIcon != null,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const SizedBox(width: 12),
                  preFixIcon != null
                      ? Column(
                        children: [
                          preFixIcon!,
                          const SizedBox(height: 4,)
                        ],
                      )
                      : const Icon(
                          Icons.arrow_right_rounded,
                          color: Colors.black,
                        )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
