import 'dart:async';

import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/public/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:otp/otp.dart';
import 'package:sliding_number/sliding_number.dart';

class LookSimpleDialog extends StatefulWidget {
  final PasswordBean passwordBean;

  ///新增密码夹页
  const LookSimpleDialog({super.key, required this.passwordBean});

  @override
  State<LookSimpleDialog> createState() => _LookSimpleDialogState();
}

class _LookSimpleDialogState extends State<LookSimpleDialog> {
  final TextEditingController _account = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _otpCode = TextEditingController();
  late bool _inputPasswordView = true;
  late int _countdown = 30;
  late Timer _timer;

  void _startTimer() {
    //初始化数据
    getOtp();
    //设置定时任务数据
    _timer = Timer.periodic(Duration(milliseconds: 1000), (Timer timer) {
      getOtp();
    });
  }

  //获取当前OTP数据
  void getOtp() {
    _otpCode.text = OTP.generateTOTPCodeString(
        "R4KIBRLA2UD7UYP7MFURLAVOXXMQKKMYBI3XXIV5WYBB6JSUEACHQZ3FP3WQ7BUM",
        int.parse(DateTime.now().millisecondsSinceEpoch.toString()),
        algorithm: Algorithm.SHA1,
        isGoogle: true);
    //获取当前剩余时间
    setState(() {
      _countdown = OTP.remainingSeconds();
    });
  }

  @override
  void initState() {
    _account.text = widget.passwordBean.account;
    _password.text = widget.passwordBean.password;
    _startTimer();
    super.initState();
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      // title: const Text('标题'),
      children: [
        //这边自己定义widget内容
        Container(
          width: 340,
          padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
          child: Column(
            children: [
              TextField(
                //账号
                //输入框样式及内字体
                controller: _account,
                decoration: InputDecoration(
                  labelText: LanguageText.account.tr,
                  hintText: LanguageText.account.tr,
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.passwordBean.account));
                      Get.showSnackbar(messageSnackBar(
                          LanguageText.accountCopiedToClipboard.tr));
                    },
                    icon: const Icon(Icons.copy),
                  ),
                ),
                //控制软键盘输入类型
                keyboardType: TextInputType.none,
              ),
              TextField(
                //密码
                //输入框样式及内字体
                controller: _password,
                decoration: InputDecoration(
                  labelText: LanguageText.password.tr,
                  hintText: LanguageText.password.tr,
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: widget.passwordBean.password));
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Get.showSnackbar(messageSnackBar(
                          LanguageText.passwordCopiedToClipboard));
                    },
                    icon: const Icon(Icons.copy),
                  ),
                  suffixIcon: IconButton(
                      onPressed: () {
                        setState(() {
                          _inputPasswordView = !_inputPasswordView;
                        });
                      },
                      icon: Icon(_inputPasswordView
                          ? Icons.visibility
                          : Icons.visibility_off)),
                ),
                //设置密码输入
                obscureText: _inputPasswordView,
                //控制软键盘输入类型
                keyboardType: TextInputType.none,
              ),
              TextField(
                //2FA
                //输入框样式及内字体
                controller: _otpCode,
                decoration: InputDecoration(
                  labelText: LanguageText.otp2FA.tr,
                  hintText: LanguageText.otp2FA.tr,
                  border: InputBorder.none,
                  prefixIcon: IconButton(
                    onPressed: () {
                      Clipboard.setData(
                          ClipboardData(text: _otpCode.text));
                      ScaffoldMessenger.of(context).removeCurrentSnackBar();
                      Get.showSnackbar(messageSnackBar(
                          LanguageText.passwordCopiedToClipboard));
                    },
                    icon: const Icon(Icons.copy),
                  ),
                  suffixIcon: SlidingNumber(
                    number: _countdown,
                    style: Theme.of(context).textTheme.displaySmall!,
                    duration: const Duration(milliseconds: 1000),
                    curve: Curves.easeOutQuint,
                  ),
                ),
                //设置密码输入
                //obscureText: _inputPasswordView,
                //控制软键盘输入类型
                keyboardType: TextInputType.none,
                //enabled: false,
              ),
            ],
          ),
        ),
      ],
    );

    ///清理所有输入参数
  }
}
