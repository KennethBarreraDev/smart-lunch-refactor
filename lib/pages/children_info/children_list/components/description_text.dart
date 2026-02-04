import 'package:flutter/material.dart';

class DescriptionText extends StatelessWidget {
  const DescriptionText({
    super.key,
    required this.title,
    required this.description,
  });

  final String title;
  final String description;

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        children: [
          TextSpan(
            style: const TextStyle(
              color: Color(0xff413931),
              fontWeight: FontWeight.w500,
              fontFamily: "Comfortaa",
              fontSize: 12.0,
            ),
            text: title,
          ),
          TextSpan(
            style: const TextStyle(
              color: Color(0xff413931),
              fontWeight: FontWeight.w300,
              fontFamily: "Comfortaa",
              fontSize: 12.0,
            ),
            text: description,
          ),
        ],
      ),
    );
  }
}
