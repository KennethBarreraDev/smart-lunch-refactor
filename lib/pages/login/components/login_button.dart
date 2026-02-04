import 'package:flutter/material.dart';
import 'package:smart_lunch/utils/colors.dart' as colors;

class LoginButton extends StatelessWidget {
  const LoginButton({
    super.key,
    required this.text,
    required this.isEnabled,
    required this.isLoading,
    this.onPressed,
  });

  final String text;
  final bool isEnabled;
  final void Function()? onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: // Rectangle 204
          Container(
        width: 225,
        height: 53,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(
            Radius.circular(30),
          ),
          color: Color(0xFFFFA66A),
        ),
        child: ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.transparent,
            shadowColor: Colors.transparent,
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30),
              ),
            ),
          ),
          onPressed: () {
            if (isEnabled) {
              onPressed?.call();
            }
          },
          child: !isLoading
              ? Text(
                  text,
                  style: const TextStyle(
                    color: colors.white,
                    fontSize: 20.0,
                    fontFamily: "Comfortaa",
                  ),
                  textAlign: TextAlign.left,
                )
              : const SizedBox(
                  width: 24,
                  height: 24,
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ),
                ),
        ),
      ),
    );
  }
}
