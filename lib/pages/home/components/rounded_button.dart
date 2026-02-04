import 'package:flutter/material.dart';

class RoundedButton extends StatelessWidget {
  const RoundedButton({
    super.key,
    required this.color,
    required this.text,
    this.iconData,
    this.verticalPadding = 8,
    this.mainAxisAlignment = MainAxisAlignment.start,
    this.enabled = true,
    this.onTap,
    this.fontSize = 14,
    this.maxWidthFactor = 0.5,
  });

  final Color color;
  final IconData? iconData;
  final String text;
  final double verticalPadding;
  final void Function()? onTap;
  final MainAxisAlignment mainAxisAlignment;
  final bool enabled;
  final double fontSize;
  final double maxWidthFactor;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return GestureDetector(
          onTap: enabled ? onTap : null,
          child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: constraints.maxWidth * maxWidthFactor,
            ),
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: verticalPadding,
                horizontal: 12,
              ),
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.all(
                  Radius.circular(50),
                ),
                color: enabled
                    ? color.withOpacity(0.15)
                    : color.withOpacity(0.07),
              ),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: mainAxisAlignment,
                children: [
                  if (iconData != null) ...[
                    Icon(
                      iconData,
                      color: enabled ? color : color.withOpacity(0.4),
                      size: fontSize + 4,
                    ),
                    const SizedBox(width: 9),
                  ],
                  Flexible(
                    child: Text(
                      text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: enabled ? color : color.withOpacity(0.4),
                        fontSize: fontSize,
                        fontFamily: "Comfortaa",
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
