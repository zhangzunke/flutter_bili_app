import 'package:flutter/material.dart';
import 'package:flutter_bili_app/http/dao/login_dao.dart';
import 'package:flutter_bili_app/util/string_util.dart';
import 'package:flutter_bili_app/util/toast.dart';
import 'package:flutter_bili_app/widget/appbar.dart';
import 'package:flutter_bili_app/widget/login_button.dart';
import 'package:flutter_bili_app/widget/login_effect.dart';
import 'package:flutter_bili_app/widget/login_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  bool isProtected = false; // Example state for protected mode
  bool loginEnable = false;
  String userName = '';
  String password = '';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar('登录', '注册', () {}),
      body: Container(
        key: const Key('login_page'),
        child: ListView(
          children: [
            LoginEffect(loginEnable),
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
            Padding(
              padding: EdgeInsets.only(left: 20, right: 20, top: 20),
              child: LoginButton(
                '登录',
                enabled: loginEnable,
                onPressed: () {
                  send();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  void checkInput() {
    bool enable;
    if (isNotEmpty(userName) && isNotEmpty(password)) {
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
      var result = await LoginDao.login(userName, password);
      if (result['code'] == 0) {
        showToast('登录成功');
      } else {
        showWarnToast('登录失败: ${result['msg']}');
      }
      // Navigate to login page or home page
    } catch (e) {
      showWarnToast('登录失败: $e');
    }
  }
}
