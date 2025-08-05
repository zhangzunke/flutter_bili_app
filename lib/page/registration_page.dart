import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/util/string_util.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_button.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';
import 'package:flutter_bili_app/widget/login_input.dart';

class RegistrationPage extends StatefulWidget {
  final VoidCallback? onJumpToLogin;
  const RegistrationPage({super.key, this.onJumpToLogin});

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
  bool isProtected = false; // Example state for protected mode
  bool loginEnable = false;
  String userName = '';
  String password = '';
  String confirmPassword = '';
  String imoocId = '';
  String orderId = '';
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
                userName = value;
                checkInput();
              },
            ),
            LoginInput(
              '密码',
              '请输入密码',
              obscureText: true,
              onChanged: (value) {
                password = value;
                checkInput();
              },
              focusChanged: (value) => setState(() {
                isProtected = value;
              }),
            ),
            LoginInput(
              '确认密码',
              '请输入确认密码',
              obscureText: true,
              onChanged: (value) {
                confirmPassword = value;
                checkInput();
              },
              focusChanged: (value) => setState(() {
                isProtected = value;
              }),
            ),
            LoginInput(
              '慕课网ID',
              '请输入慕课网ID',
              keyboardType: TextInputType.number,
              onChanged: (value) {
                imoocId = value;
                checkInput();
              },
            ),
            LoginInput(
              '订单后四位',
              '请输入订单后四位',
              lineStretch: true,
              keyboardType: TextInputType.number,
              onChanged: (value) {
                orderId = value;
                checkInput();
              },
            ),
            LoginButton(
              '注册',
              enabled: loginEnable,
              onPressed: () {
                checkParams();
              },
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) &&
        isNotEmpty(password) &&
        isNotEmpty(confirmPassword) &&
        isNotEmpty(imoocId) &&
        isNotEmpty(orderId)) {
      enable = true;
    } else {
      enable = false;
    }

    setState(() {
      loginEnable = enable;
    });
  }

  void send() async {
    try {
      // Simulate sending registration data
      var result = await LoginDao.registration(
        userName,
        password,
        imoocId,
        orderId,
      );
      if (result['code'] == 0) {
        _showSnackBarSafe('注册成功');
        if (widget.onJumpToLogin != null) {
          widget.onJumpToLogin!();
        }
      } else {
        _showSnackBarSafe('注册失败: ${result['msg']}');
      }
      // Navigate to login page or home page
    } catch (e) {
      _showSnackBarSafe('注册失败: $e');
    }
  }

  void _showSnackBarSafe(String message) {
    if (!mounted) return;
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: const TextStyle(fontSize: 16, color: Colors.red),
        ),
      ),
    );
  }

  void checkParams() {
    String? tips;
    if (password != confirmPassword) {
      tips = '两次输入的密码不一致';
    } else if (orderId.length != 4) {
      tips = '订单后四位必须为四位';
    }
    if (tips != null) {
      _showSnackBarSafe(tips);
      return;
    }
    send();
  }
}
