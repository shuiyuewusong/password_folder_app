import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/password/widget/password_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 修改密码页
class PasswordEditPage extends StatefulWidget {
  /// 修改密码页
  const PasswordEditPage({super.key});

  @override
  State<PasswordEditPage> createState() => _PasswordEditPageState();
}

class _PasswordEditPageState extends State<PasswordEditPage> {
  final GlobalKey<PasswordFormPageState> _globalKey =
      GlobalKey<PasswordFormPageState>();

  late PasswordBean _passwordBean;

  @override
  void initState() {
    super.initState();
    // debugPrint(widget.arguments[beanPassword].toMap().toString());
    // final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    //
    // _passwordBean = arguments;
    // _passwordBean = PasswordBean();
    //设置初始值
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arguments = ModalRoute.of(context)!.settings.arguments;
    _passwordBean = arguments[PasswordBean.beanPassword];
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.titleEdit.tr),
        actions: [
          IconButton(
            onPressed: () {
              _globalKey.currentState!.put();
            },
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: PasswordFormPage(
        key: _globalKey,
        passwordBean: _passwordBean,
        isAdd: false,
      ),
    );
  }
}
