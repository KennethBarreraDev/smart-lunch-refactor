import 'package:flutter/material.dart';

class FormMessage extends StatelessWidget {
  const FormMessage({
    super.key,
    required this.color,
    required this.iconData,
    required this.text,
  });

  final Color color;
  final IconData iconData;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        vertical: 7,
        horizontal: 5,
      ),
      margin: const EdgeInsets.only(
        top: 24,
      ),
      decoration: BoxDecoration(
        color: color.withOpacity(0.25),
        borderRadius: const BorderRadius.all(
          Radius.circular(6),
        ),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Icon(
              iconData,
              color: color,
            ),
          ),
          Expanded(
            flex: 6,
            child: Text(
              text,
              style: TextStyle(
                color: color,
                fontSize: 16,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
