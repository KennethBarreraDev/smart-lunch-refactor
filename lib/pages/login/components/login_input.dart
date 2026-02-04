import 'package:flutter/material.dart';

class LoginInput extends StatelessWidget {
  const LoginInput({
    super.key,
    required this.textInputType,
    required this.labelText,
    this.obscurePassword = false,
    this.onVisibilityChange,
    this.textEditingController,
    this.onChange 
  });

  final TextInputType textInputType;
  final bool obscurePassword;
  final void Function()? onVisibilityChange;
  final void Function(String)? onChange;
  final String labelText;
  final TextEditingController? textEditingController;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      onChanged: onChange,
      autocorrect: false,
      obscureText: obscurePassword,
      keyboardType: textInputType,
      controller: textEditingController,
      decoration: InputDecoration(
        suffixIcon: onVisibilityChange != null
            ? IconButton(
                icon: Icon(
                  obscurePassword ? Icons.visibility : Icons.visibility_off,
                ),
                onPressed: onVisibilityChange,
              )
            : null,
        border: const UnderlineInputBorder(
          borderSide: BorderSide(
            color: Color(0xffef5360),
          ),
          borderRadius: BorderRadius.all(
            Radius.circular(
              4,
            ),
          ),
        ),
        labelText: labelText,
        labelStyle: TextStyle(
          color: const Color(0xff0b123d).withOpacity(0.75),
          fontFamily: "Comfortaa",
        ),
      ),
    );
  }
}
