import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/public/snack_bar_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

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
  bool inputPasswordView = true;

  @override
  void initState() {
    _account.text = widget.passwordBean.account;
    _password.text = widget.passwordBean.password;
    super.initState();
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
                          inputPasswordView = !inputPasswordView;
                        });
                      },
                      icon: Icon(inputPasswordView
                          ? Icons.visibility
                          : Icons.visibility_off)),
                ),
                //设置密码输入
                obscureText: inputPasswordView,
                //控制软键盘输入类型
                keyboardType: TextInputType.none,
              ),
            ],
          ),
        ),
      ],
    );

    ///清理所有输入参数
  }
}
