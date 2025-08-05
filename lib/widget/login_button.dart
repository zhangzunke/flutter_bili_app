import 'package:flutter/material.dart';
import 'package:flutter_bili_app/util/color.dart';

class LoginButton extends StatelessWidget {
  final String title;
  final bool enabled;
  final VoidCallback? onPressed;
  const LoginButton(
    this.title, {
    super.key,
    this.enabled = false,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: 1,
      child: MaterialButton(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
        height: 45,
        onPressed: enabled ? onPressed : null,
        disabledColor: primaryColor[50],
        color: primaryColor,
        child: Text(
          title,
          style: const TextStyle(color: Colors.white, fontSize: 16),
        ),
      ),
    );
  }
}
