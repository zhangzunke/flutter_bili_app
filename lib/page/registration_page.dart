import 'package:flutter/material.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';
import 'package:flutter_bili_app/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({super.key});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isProtected = false; // Example state for protected mode
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('注册', '登录', () {
        // Navigate to login page
        // Navigator.pop(context);
      }),
      body: Container(
        key: const Key('registration_page'),
        child: ListView(
          children: [
            LoginEffect(isProtected),
            LoginInput(
              '用户名',
              '请输入用户名',
              onChanged: (value) {
                // Handle username input
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true,
              onChanged: (value) {
                // Handle password input
              },
              focusChanged: (value) => setState(() {
                isProtected = value;
              }),
            ),
            LoginInput(
              '确认密码',
              '请输入确认密码',
              obscureText: true,
              lineStretch: true,
              onChanged: (value) {
                // Handle confirm password input
              },
            ),
            ElevatedButton(
              onPressed: () {
                // Handle registration logic
              },
              child: const Text('注册'),
            ),
          ],
        ),
      ),
    );
  }
}
