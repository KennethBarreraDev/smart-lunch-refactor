import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

class ExpirationDateField extends StatelessWidget {
  const ExpirationDateField({
    super.key,
    required this.expirationMonthController,
    required this.expirationYearController,
  });

  final TextEditingController expirationMonthController;
  final TextEditingController expirationYearController;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Expanded(
          child: TextFormField(
             maxLength: 2,
            controller: expirationMonthController,
            decoration: const InputDecoration(
              labelText: "MM",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        const Text(
          "/",
          style: TextStyle(
            color: colors.darkBlue,
            fontSize: 32,
            fontWeight: FontWeight.w300,
          ),
        ),
        const SizedBox(
          width: 5,
        ),
        Expanded(
          child: TextFormField(
             maxLength: 2,
            controller: expirationYearController,
            decoration: const InputDecoration(
              labelText: "YY",
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.number,
          ),
        ),
      ],
    );
  }
}
