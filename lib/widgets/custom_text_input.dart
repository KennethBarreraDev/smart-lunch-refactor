import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

class CustomTextInput extends StatelessWidget {
  const CustomTextInput({
    super.key,
    required this.label,
    this.textInputType = TextInputType.text,
    this.enabled = true,
    this.textCapitalization = TextCapitalization.none,
    this.obscurePassword = false,
    this.onVisibilityChange,
    this.initialValue,
    this.textEditingController,
    this.onChanged,
    this.onTap,
  });

  final String label;
  final String? initialValue;
  final TextEditingController? textEditingController;
  final TextInputType textInputType;
  final bool enabled;
  final TextCapitalization textCapitalization;
  final bool obscurePassword;
  final void Function()? onVisibilityChange;
  final void Function(String)? onChanged;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(
        bottom: 24,
      ),
      color: !enabled ? const Color(0xfff0f1f5) : null,
      child: GestureDetector(
        onTap: onTap,
        child: TextFormField(
          controller: textEditingController,
          initialValue: initialValue,
          textCapitalization: textCapitalization,
          autocorrect: false,
          obscureText: obscurePassword,
          keyboardType: textInputType,
          enabled: enabled && onTap == null,
          onChanged: onChanged,
          decoration: InputDecoration(
            suffixIcon: onVisibilityChange != null
                ? IconButton(
                    icon: Icon(
                      obscurePassword ? Icons.visibility : Icons.visibility_off,
                    ),
                    onPressed: onVisibilityChange,
                  )
                : null,
            border: OutlineInputBorder(
              borderSide: BorderSide(
                color: colors.darkBlue.withOpacity(0.08),
              ),
              borderRadius: const BorderRadius.all(
                Radius.circular(
                  4,
                ),
              ),
            ),
            labelText: label,
            labelStyle: TextStyle(
              color: const Color(0xff0b123d).withOpacity(0.75),
                fontFamily: "Comfortaa"
            ),
          ),
        ),
      ),
    );
  }
}
