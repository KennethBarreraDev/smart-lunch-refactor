import 'package:flutter/material.dart';

class StatusIndicator extends StatelessWidget {
  const StatusIndicator({
    super.key,
    required this.color,
    required this.status,
  });

  final Color color;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            borderRadius: const BorderRadius.all(
              Radius.circular(
                6,
              ),
            ),
            color: color,
          ),
        ),
        const SizedBox(
          width: 4,
        ),
        Text(
          status,
          style: TextStyle(
            color: color,
            fontWeight: FontWeight.w300,
            fontFamily: "Comfortaa",
          ),
        )
      ],
    );
  }
}
