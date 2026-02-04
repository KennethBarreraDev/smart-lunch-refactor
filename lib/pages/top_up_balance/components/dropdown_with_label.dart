import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

class DropdownWithLabel extends StatelessWidget {
  const DropdownWithLabel({
    super.key,
    required this.label,
    required this.initialValue,
    required this.options,
    required this.onChanged,
  });

  final String label;
  final void Function(String?)? onChanged;
  final String initialValue;
  final List<List<String>> options;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Text(
          label,
          style: const TextStyle(
            color: colors.darkBlue,
            fontWeight: FontWeight.w700,
            fontSize: 12.0,
          ),
        ),
        DropdownButton(
          items: options
              .map(
                (option) => DropdownMenuItem(
                  value: option[0],
                  child: Text(
                    option[1],
                    style: const TextStyle(
                      color: colors.darkBlue,
                      fontWeight: FontWeight.w500,
                      fontSize: 18.0,
                    ),
                  ),
                ),
              )
              .toList(),
          isExpanded: true,
          value: initialValue,
          icon: const Icon(
            Icons.arrow_drop_down_outlined,
          ),
          onChanged: (value) {
            onChanged?.call(value);
          },
        ),
      ],
    );
  }
}
