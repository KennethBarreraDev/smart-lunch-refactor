import 'package:flutter/material.dart';

class LabeledCheckbox extends StatelessWidget {
  const LabeledCheckbox({
    Key? key,
    required this.label,
    required this.value,
    required this.onChanged,
    this.id,
  }) : super(key: key);

  final String label;
  final bool value;
  final Function onChanged;
  final int? id;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (id == null) {
          onChanged(!value);
        } else {
          onChanged(id);
        }
      },
      child: Row(
        children: <Widget>[
          Checkbox(
            value: value,
            onChanged: (bool? newValue) {
              if (id == null) {
                onChanged(newValue);
              } else {
                onChanged(id);
              }
            },
          ),
          Text(label),
        ],
      ),
    );
  }
}
