import 'package:flutter/material.dart';

class StackedTexts extends StatelessWidget {
  const StackedTexts({
    super.key,
    required this.title,
    required this.subtitle,
  });

  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            color: const Color(0xff413931).withOpacity(0.5),
            fontWeight: FontWeight.w300,
            fontFamily: "Comfortaa",
            fontSize: 12.0,
          ),
        ),
        const SizedBox(
          height: 5,
        ),
        Text(
          subtitle,
          style: const TextStyle(
            color: Color(0xff413931),
            fontWeight: FontWeight.w600,
            fontFamily: "Comfortaa",
            fontSize: 12.0,
          ),
        ),
      ],
    );
  }
}
