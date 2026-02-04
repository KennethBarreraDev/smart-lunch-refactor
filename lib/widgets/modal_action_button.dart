import 'package:flutter/material.dart';

class ModalActionButton extends StatelessWidget {
  
  const ModalActionButton({
    super.key,
    required this.backgroundColor,
    required this.primaryColor,
    required this.borderRadius,
    required this.text,
    this.onTap,
    this.iconData,
    this.largeIcon,
    this.quarterTurns = 0,
    this.textFontWeight = FontWeight.w500,
    this.textFontSize = 16,
    this.isLoading = false,
  });

  final Color backgroundColor;
  final Color primaryColor;
  final void Function()? onTap;
  final BorderRadiusGeometry borderRadius;
  final IconData? iconData;
  final int quarterTurns;
  final String text;
  final FontWeight textFontWeight;
  final double textFontSize;
  final bool isLoading;
  final IconData? largeIcon;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: borderRadius,
        ),
        margin: const EdgeInsets.only(
          top: 9,
        ),
        padding: const EdgeInsets.symmetric(
          vertical: 17,
        ),
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SizedBox(
                    width: 16,
                    height: 16,
                    child: CircularProgressIndicator(
                      color: primaryColor,
                    ),
                  ),
                ],
              )
            : Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisSize: MainAxisSize.max,
                children: [
                  if (iconData != null)
                    Transform.scale(
                      scaleY: -1,
                      child: RotatedBox(
                        quarterTurns: quarterTurns,
                        child: Icon(
                          iconData,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  if (largeIcon != null)
                    Padding(
                      padding: const EdgeInsets.only(right: 7),
                      child: Icon(
                        largeIcon,
                        color: primaryColor,
                        size: 35,
                      ),
                    ),
                  Text(
                    text,
                    style: TextStyle(
                      color: primaryColor,
                      fontWeight: textFontWeight,
                      fontSize: textFontSize,
                    ),
                  )
                ],
              ),
      ),
    );
  }
}
