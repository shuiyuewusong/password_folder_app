import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/page/password/widget/password_form.dart';
import 'package:flutter/material.dart';

/// 修改密码页
class PasswordViewPage extends StatefulWidget {
  /// 修改密码页
  const PasswordViewPage({super.key});

  @override
  State<PasswordViewPage> createState() => _PasswordViewPageState();
}

class _PasswordViewPageState extends State<PasswordViewPage> {
  final GlobalKey<PasswordFormPageState> _globalKey =
      GlobalKey<PasswordFormPageState>();

  late PasswordBean _passwordBean;

  late bool _readOnly;

  @override
  void initState() {
    super.initState();
    _readOnly = true;
    //设置初始值
  }

  @override
  Widget build(BuildContext context) {
    final dynamic arg = ModalRoute.of(context)!.settings.arguments;
    _passwordBean = arg[PasswordBean.beanPassword];
    return Scaffold(
      appBar: AppBar(
        title: Text(_passwordBean.name),
        actions: [
          ///删除当前账户
          Visibility(
            visible: !_readOnly,
            child: IconButton(
              onPressed: () {
                _globalKey.currentState!.delete();
              },
              icon: const Icon(Icons.delete),
            ),
          ),

          ///保存按钮
          Visibility(
            visible: !_readOnly,
            child: IconButton(
              onPressed: () {
                _globalKey.currentState!.put();
              },
              icon: const Icon(Icons.save),
            ),
          ),
          IconButton(
            onPressed: () {
              setState(() {
                _readOnly = !_readOnly;
              });
            },
            icon: _readOnly ? const Icon(Icons.edit) : const Icon(Icons.clear),
          )
        ],
      ),
      body: PasswordFormPage(
        key: _globalKey,
        passwordBean: _passwordBean,
        isAdd: false,
        readOnly: _readOnly,
      ),
    );
  }
}
