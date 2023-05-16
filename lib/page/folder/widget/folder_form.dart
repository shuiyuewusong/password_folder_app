import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/public/sized_box_widget.dart';
import 'package:password_folder_app/page/public/small_components.dart';
import 'package:password_folder_app/page/public/snack_bar_widget.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:password_folder_app/service/folder_service.dart';

class FolderFormPage extends StatefulWidget {
  final FolderBean folderBean;
  final bool isAdd;

  const FolderFormPage({
    Key? key,
    required this.folderBean,
    this.isAdd = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return FolderFormPageState();
  }
}

class FolderFormPageState extends State<FolderFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  final TextEditingController _name = TextEditingController();
  final TextEditingController _notes = TextEditingController();
  final TextEditingController _orders = TextEditingController();

  late FolderBean _folderBean;

  @override
  void initState() {
    super.initState();
    _folderBean = widget.folderBean.clone(widget.folderBean);

    ///设置初始值 如果是修改设置初始值 如果是新增不操作
    if (widget.isAdd) {
    } else {
      _name.text = _folderBean.name;
      _notes.text = _folderBean.notes;
      _orders.text = _folderBean.orders.toString();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {},
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(10, 20, 20, 10),
        child: Column(
          children: [
            // Text("请输入相应信息进行密码创建"),
            TextFormField(
              //输入框样式及内字体
              controller: _name,
              decoration: InputDecoration(
                icon: const Icon(Icons.folder),
                labelText: LanguageText.name.tr,
                border: const OutlineInputBorder(),
                counterText: '',
                hintText: LanguageText.name.tr,
              ),
              //输入验证
              validator: (value) => inputValidator(value, LanguageText.name.tr),
              //是否自动获取焦点。
              autofocus: false,
              //输入框最大长度。
              maxLength: 10,
              //软键盘回车键图标。
              textInputAction: TextInputAction.next,
              //输入触发事件
              onChanged: (value) {
                _folderBean.name = value;
              },
            ),
            const SizedBoxWidget(),
            TextFormField(
              controller: _notes,
              decoration: InputDecoration(
                icon: const Icon(Icons.notes),
                labelText: LanguageText.notes.tr,
                border: const OutlineInputBorder(),
                hintText: LanguageText.notes.tr,
                counterText: '',
              ),
              //输入框最大长度。
              maxLength: 255,
              //软键盘回车键图标。
              textInputAction: TextInputAction.next,
              onChanged: (value) {
                _folderBean.notes = value;
              },
            ),
            const SizedBoxWidget(),
            TextFormField(
              controller: _orders,
              //输入框样式及内字体
              decoration: InputDecoration(
                icon: const Icon(Icons.unfold_more),
                labelText: LanguageText.order.tr,
                border: const OutlineInputBorder(),
                hintText: LanguageText.theSmallerTheNumberTheHigherTheOrder.tr,
                counterText: '',
              ),
              //输入验证
              validator: (value) =>
                  inputValidator(value, LanguageText.order.tr),
              //限制仅输入数字
              inputFormatters: [
                FilteringTextInputFormatter.digitsOnly,
              ],
              //控制软键盘输入类型
              keyboardType: TextInputType.number,
              //输入框最大长度。
              maxLength: 5,
              onChanged: (value) {
                //不为空才赋值
                if (value.isNotEmpty) {
                  _folderBean.orders = int.parse(value);
                }
              },
            ),
            const SizedBoxWidget(),
          ],
        ),
      ),
    );
  }

  void delete() {
    //显示对话框
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          //设置左上提示字符
          title: Text(
            LanguageText.remind.tr,
            style: const TextStyle(color: Colors.red),
          ),
          //设置中间提示字符
          content: Text(LanguageText.whetherToDeleteThePassword.tr),
          actions: [
            //设置确认按钮
            TextButton(
              child: Text(LanguageText.delete.tr),
              onPressed: () {
                _deleteData();
              },
            ),
            TextButton(
              child: Text(LanguageText.cancel.tr),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  ///删除密码夹
  void _deleteData() {
    //有密码不进行删除
    final Future<bool> future = FolderService().delete(_folderBean);
    future.then((value) {
      if (value) {
        Navigator.of(context)
            .popUntil(ModalRoute.withName(RoutingTable.folderSetting));
        Get.showSnackbar(messageSnackBar(LanguageText.deleteComplete.tr));
      } else {
        Navigator.of(context).pop();
        Get.showSnackbar(messageSnackBar(
            LanguageText.unableToDeletePasswordFolderWithPassword.tr));
      }
    });
  }

  ///存储数据
  void put() {
    if (_formKey.currentState!.validate()) {
      debugPrint('_folderBean.id.toString():${_folderBean.id}');
      final Future future = FolderService().add(_folderBean);
      future.then((value) {
        debugPrint('value:$value');
        debugPrint('_folderBean.id.toString():${_folderBean.id}');
        Navigator.of(context)
            .popUntil(ModalRoute.withName(RoutingTable.folderSetting));
        Get.showSnackbar(messageSnackBar(LanguageText.saveComplete.tr));
      });
    }
  }

  ///清理所有输入参数
  void clearAll() {
    _folderBean = widget.folderBean.clone(widget.folderBean);
    debugPrint('clearAll');
    if (widget.isAdd) {
      debugPrint('true');
      _formKey.currentState!.reset();
    } else {
      debugPrint('false');
      _name.text = _folderBean.name;
      _notes.text = _folderBean.notes;
      _orders.text = _folderBean.orders.toString();
    }
  }
}
