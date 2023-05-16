import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/password/widget/password_form.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

/// 新建密码页
class PasswordAddPage extends StatefulWidget {
  /// 新建密码页
  const PasswordAddPage({super.key});

  @override
  State<PasswordAddPage> createState() => _PasswordAddPageState();
}

class _PasswordAddPageState extends State<PasswordAddPage> {
  final GlobalKey<PasswordFormPageState> _globalKey =
      GlobalKey<PasswordFormPageState>();

  late PasswordBean _passwordBean;

  @override
  void initState() {
    super.initState();

    //设置初始值
  }

  @override
  Widget build(BuildContext context) {
    _passwordBean = PasswordBean();
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.titleCreate.tr),
        actions: [
          Tooltip(
            message: LanguageText.save.tr,
            child: IconButton(
              onPressed: () {
                _globalKey.currentState!.put();
              },
              icon: const Icon(Icons.save),
            ),
          ),

          // IconButton(
          //   onPressed: () {
          //     _globalKey.currentState!.clearAll();
          //   },
          //   icon: const Icon(Icons.clear),
          // )
        ],
      ),
      body: PasswordFormPage(
        key: _globalKey,
        passwordBean: _passwordBean,
        isAdd: true,
      ),
    );
  }
}
