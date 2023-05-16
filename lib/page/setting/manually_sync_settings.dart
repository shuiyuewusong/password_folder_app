import 'dart:convert';
import 'dart:developer';

import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/data/folder_data.dart';
import 'package:password_folder_app/data/password_data.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/public/encrypt_util.dart';
import 'package:password_folder_app/page/public/snack_bar_widget.dart';
import 'package:password_folder_app/service/folder_service.dart';
import 'package:password_folder_app/service/password_service.dart';

// import 'package:encrypt/encrypt.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';

///手动同步数据页
class ManuallySyncSettingsPage extends StatefulWidget {
  ///手动同步数据页
  const ManuallySyncSettingsPage({super.key});

  @override
  State<ManuallySyncSettingsPage> createState() =>
      _ManuallySyncSettingsPageState();
}

///手动同步数据页
class _ManuallySyncSettingsPageState extends State<ManuallySyncSettingsPage> {
  final TextEditingController _password = TextEditingController();
  final TextEditingController _data = TextEditingController();
  late bool _inputPasswordView;

  @override
  void initState() {
    super.initState();
    PasswordService().refreshListOfAll(context);
    _inputPasswordView = true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(LanguageText.manuallySyncSettings.tr),
        actions: [
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.save),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.fromLTRB(10, 20, 20, 0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text("点击导出按钮可以将数据导出至剪贴板,输入自定义密码可加密数据.",
                  style: TextStyle(fontSize: 16)),
              const Text("点击导入数据可将数据导入,如数据被加密则需要输入密码.",
                  style: TextStyle(fontSize: 16)),
              TextField(
                //输入框样式及内字体
                controller: _password,
                decoration: InputDecoration(
                  labelText: LanguageText.password.tr,
                  hintText: LanguageText.password.tr,
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
                //输入验证
                // 设置密码输入
                obscureText: _inputPasswordView,
                //是否自动获取焦点。
                autofocus: false,
                //控制软键盘输入类型
                keyboardType: TextInputType.visiblePassword,
                //输入触发事件
                onChanged: (value) {
                  debugPrint(value);
                },
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(

                  onPressed: () {
                    _export();
                  },
                  child: const Text('导出数据'),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              TextField(
                //输入框样式及内字体
                controller: _data,
                decoration: InputDecoration(
                  labelText: LanguageText.data.tr,
                  border: const OutlineInputBorder(),
                  suffixIcon: IconButton(
                    onPressed: () {
                      setState(() {
                        _data.clear();
                      });
                    },
                    icon: const Icon(Icons.clear),
                  ),
                ),
                //输入验证
                maxLines: 15,
                minLines: 5,
                keyboardType: TextInputType.none,
                // maxLength: 999999999,
                //是否自动获取焦点。
                autofocus: false,
                //输入触发事件
                onChanged: (value) {},
              ),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    debugPrint('导入数据');
                    _import();
                  },
                  child: const Text('导入数据'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _export() {
    ///整理密码夹相关数据
    final List<Map<String, dynamic>> mFList = [];
    final List<FolderBean> fList =
        Provider.of<FolderData>(context, listen: false).getFolderList;
    for (FolderBean folderBean in fList) {
      mFList.add(folderBean.getMap());
    }
    String fStr = json.encode(mFList);
    debugPrint(fStr);

    ///整理密码相关数据
    final List<Map<String, dynamic>> mPList = [];
    final List<PasswordBean> pList =
        Provider.of<PasswordData>(context, listen: false).getPasswordList;
    for (PasswordBean passwordBean in pList) {
      mPList.add(passwordBean.getMap());
    }
    String pStr = json.encode(mPList);
    debugPrint(pStr);

    ///数据打包加密 如果没有设置密码则不加密
    String data = fStr + _jjj + pStr;
    if (_password.text.isNotEmpty) {
      _data.text = EncryptUtil.exportData(_passwordUtil(), data);
    } else {
      _data.text = data;
    }
    debugPrint(_data.text);
    //将数据写入到剪贴板并提醒
    Clipboard.setData(ClipboardData(text: data));
    Get.showSnackbar(messageSnackBar(LanguageText.importSuccessfully.tr));
  }

  _import() {
    try {
      final String str;

      ///如果没有输入密码则不进行解密
      if (_password.text.isNotEmpty) {
        str = EncryptUtil.importData(_passwordUtil(), _data.text);
      } else {
        str = _data.text;
      }
      log('logStr:$str');
      final List<String> list = str.split(_jjj);
      log('list.toString():${list.toString()}');
      final folderStr = list[0];
      log('folderStr:$folderStr');
      final passwordStr = list[1];
      log('passwordStr:$passwordStr');

      final List<dynamic> mFList = json.decode(folderStr);
      final List<dynamic> mPList = json.decode(passwordStr);
      final List<FolderBean> fList = [];
      final List<PasswordBean> pList = [];
      for (Map<String, dynamic> map in mFList) {
        FolderBean folderBean = FolderBean();
        folderBean.setMap(map);
        fList.add(folderBean);
      }
      for (Map<String, dynamic> map in mPList) {
        PasswordBean passwordBean = PasswordBean();
        passwordBean.setMap(map);
        pList.add(passwordBean);
      }
      FolderService().updateAll(fList);
      PasswordService().updateAll(pList);
      Get.showSnackbar(messageSnackBar(LanguageText.importSuccessfully.tr));
      debugPrint('end');
    } catch (e) {
      Get.showSnackbar(
          messageSnackBar(LanguageText.importDataExceptionDataUnavailable.tr));
    }
    debugPrint('end');
  }

  String _passwordUtil() {
    String pw = _password.text;
    debugPrint('_export:$pw');
    if (pw.length == 32) {
      // return pw;
    } else if (pw.length < 32) {
      int a = 32 - pw.length;

      pw = pw + ('A' * a);
    } else {
      pw = pw.substring(0, 32);
    }
    debugPrint('_export:$pw');
    return pw;
  }

  static const String _jjj = '##########';
}
