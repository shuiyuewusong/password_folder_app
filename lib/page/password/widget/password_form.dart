import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/bean/password_bean.dart';
import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/page/public/sized_box_widget.dart';
import 'package:password_folder_app/page/public/small_components.dart';
import 'package:password_folder_app/page/public/snack_bar_widget.dart';
import 'package:password_folder_app/routes/routing_table.dart';
import 'package:password_folder_app/service/folder_service.dart';
import 'package:password_folder_app/service/password_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';

class PasswordFormPage extends StatefulWidget {
  final PasswordBean passwordBean;
  final bool isAdd;
  final bool readOnly;

  const PasswordFormPage({
    Key? key,
    required this.passwordBean,
    this.isAdd = false,
    this.readOnly = false,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() {
    return PasswordFormPageState();
  }
}

class PasswordFormPageState extends State<PasswordFormPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  ///下拉菜单
  final GlobalKey<FormFieldState> _folderDropdownButtonFormFieldKey =
      GlobalKey<FormFieldState>();

  ///密码名称
  final TextEditingController _name = TextEditingController();

  ///密码账户
  final TextEditingController _account = TextEditingController();

  ///密码
  final TextEditingController _password = TextEditingController();

  ///邮箱
  final TextEditingController _email = TextEditingController();

  ///网络地址
  final TextEditingController _networkAddress = TextEditingController();

  ///密码排序
  final TextEditingController _orders = TextEditingController();

  ///密码备注
  final TextEditingController _notes = TextEditingController();

  ///密码实体类
  late PasswordBean _passwordBean;

  late String? _folderId;

  late bool _inputPasswordView;

  // late bool widget.readOnly;

  @override
  void initState() {
    debugPrint("pv -1");
    super.initState();
    _inputPasswordView = true;
    // widget.readOnly = widget.readOnly;
    _passwordBean = widget.passwordBean.clone(widget.passwordBean);
    debugPrint(_passwordBean.getMap().toString());

    ///设置初始值 如果是修改设置初始值 如果是新增不操作
    if (widget.isAdd) {
    } else {
      _name.text = _passwordBean.name;
      _account.text = _passwordBean.account;
      _password.text = _passwordBean.password;
      _notes.text = _passwordBean.notes;
      _orders.text = _passwordBean.orders.toString();
      _email.text = _passwordBean.email;
      _networkAddress.text = _passwordBean.networkAddress;
      _folderId = _passwordBean.folderId;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: AutovalidateMode.always,
      onChanged: () {},
      child: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(10, 0, 20, 10),
          // direction: Axis.vertical,
          child: Column(
            children: [
              _nameTextField(),
              const SizedBoxWidget(),
              _folderDropdownButtonFormField(context),
              const SizedBoxWidget(),
              _accountTextField(),
              const SizedBoxWidget(),
              _passwordTextField(),
              const SizedBoxWidget(),
              _notesTextField(),
              const SizedBoxWidget(),
              _ordersTextField(),
              const SizedBoxWidget(),
              _emailTextField(),
              const SizedBoxWidget(),
              _networkAddressTextField(),
              const SizedBoxWidget(),

              ///根据输入状态隐藏组件
              // Visibility(
              //   visible: !widget.readOnly,
              //   child: ConstrainedBox(
              //     constraints: const BoxConstraints(
              //       minWidth: double.infinity,
              //     ),
              //     child: ElevatedButton(
              //       child: const Text('保存'),
              //       onPressed: () {
              //         put();
              //       },
              //     ),
              //   ),
              // ),
            ],
          )),
    );
  }

  ///删除方法
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
                //显示对话框
              },
            ),
            TextButton(
              child: Text(LanguageText.cancel.tr),
              onPressed: () {
                //退回到首页
                Navigator.of(context)
                    .popUntil(ModalRoute.withName(RoutingTable.homePage));
              },
            ),
          ],
        );
      },
    );
  }

  ///删除数据
  void _deleteData() {
    final Future<bool> future = PasswordService().delete(_passwordBean);
    future.then((value) {
      Navigator.of(context)
          .popUntil(ModalRoute.withName(RoutingTable.homePage));
      Get.showSnackbar(messageSnackBar(LanguageText.deleteComplete.tr));
    });
  }

  ///存储数据
  void put() {
    if (_formKey.currentState!.validate()) {
      debugPrint('passwordPut');
      final Future<int> future = PasswordService().add(_passwordBean);
      future.then((value) {
        //退回到首页
        Navigator.of(context)
            .popUntil(ModalRoute.withName(RoutingTable.homePage));
        //弹窗提示保存成功
        Get.showSnackbar(messageSnackBar(LanguageText.saveComplete.tr));
      });
    } else {
      Get.showSnackbar(messageSnackBar(
        LanguageText.pleaseCompleteTheContentToSave.tr,
        milliseconds: 2000,
      ));
    }
  }

  ///清理所有输入参数
  void clearAll() {
    debugPrint(_passwordBean.getMap().toString());
    debugPrint(widget.passwordBean.getMap().toString());
    _passwordBean = widget.passwordBean.clone(widget.passwordBean);
    debugPrint('clearAll');
    if (widget.isAdd) {
      debugPrint('true');
      _formKey.currentState!.reset();
    } else {
      debugPrint('false');
      _name.text = _passwordBean.name;
      _account.text = _passwordBean.account;
      _password.text = _passwordBean.password;
      _notes.text = _passwordBean.notes;
      _orders.text = _passwordBean.orders.toString();
      _email.text = _passwordBean.email;
      _networkAddress.text = _passwordBean.networkAddress;
      _folderDropdownButtonFormFieldKey.currentState!.reset();
      _folderId = _passwordBean.folderId;
    }
  }

  ///密码名称输入框
  TextFormField _nameTextField() {
    return TextFormField(
      //输入框样式及内字体
      controller: _name,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        icon: const Icon(Icons.bookmark),
        labelText: LanguageText.name.tr,
        border: const UnderlineInputBorder(),
        counterText: '',
        hintText: LanguageText.name.tr,
      ),
      validator: (value) => inputValidator(value, LanguageText.name.tr),

      //是否自动获取焦点。
      autofocus: false,
      //输入框最大长度。
      maxLength: 10,
      //软键盘回车键图标。23
      textInputAction: next(),
      //输入触发事件
      onChanged: (value) {
        _passwordBean.name = value;
      },
    );
  }

  ///账户输入框
  TextFormField _accountTextField() {
    return TextFormField(
      //输入框样式及内字体
      controller: _account,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        icon: const Icon(Icons.account_box),
        labelText: LanguageText.account.tr,
        border: const UnderlineInputBorder(),
        counterText: '',
        hintText: LanguageText.account.tr,
      ),
      // validator: (value) => inputValidator(value, "账户"),

      //是否自动获取焦点。
      autofocus: false,
      //输入框最大长度。
      maxLength: 128,
      //软键盘回车键图标。
      textInputAction: next(),
      //设置键盘输入类型
      keyboardType: TextInputType.emailAddress,
      //输入触发事件
      onChanged: (value) {
        _passwordBean.account = value;
      },
    );
  }

  ///密码输入框
  TextFormField _passwordTextField() {
    return TextFormField(
//输入框样式及内字体
      controller: _password,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        labelText: LanguageText.password.tr,
        border: const UnderlineInputBorder(),
        icon: const Icon(Icons.key),
        counterText: '',
        suffixIcon: IconButton(
          onPressed: () {
            setState(() {
              _inputPasswordView = !_inputPasswordView;
            });
          },
          icon: Icon(
              _inputPasswordView ? Icons.visibility : Icons.visibility_off),
        ),
        hintText: LanguageText.password.tr,
      ),
      // validator: (value) => inputValidator(value, "密码"),
      //是否自动获取焦点。
      autofocus: false,
      // 设置密码输入
      obscureText: _inputPasswordView,
      //输入框最大长度。
      maxLength: 128,
      //控制软键盘输入类型
      keyboardType: TextInputType.visiblePassword,
      //软键盘回车键图标。
      textInputAction: next(),
      //输入触发事件
      onChanged: (value) {
        _passwordBean.password = value;
      },
    );
  }

  /// 备注输入框
  TextFormField _notesTextField() {
    return TextFormField(
      controller: _notes,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        labelText: LanguageText.notes.tr,
        icon: const Icon(Icons.notes),
        border: const UnderlineInputBorder(),
        counterText: '',
        hintText: LanguageText.notes.tr,
      ),
      // validator: (value) => inputValidator(value, "密码备注"),
      //输入框最大长度。
      maxLength: 255,
      //软键盘回车键图标。
      textInputAction: next(),
      onChanged: (value) {
        _passwordBean.notes = value;
      },
    );
  }

  ///排序输入框
  TextFormField _ordersTextField() {
    return TextFormField(
      controller: _orders,
      readOnly: widget.readOnly,
      //输入框样式及内字体
      decoration: InputDecoration(
        labelText: LanguageText.order.tr,
        icon: const Icon(Icons.unfold_more),
        border: const UnderlineInputBorder(),
        counterText: '',
        hintText: LanguageText.theSmallerTheNumberTheHigherTheOrder.tr,
      ),
      // validator: (value) => inputValidator(value, "排序"),
      //限制仅输入数字
      inputFormatters: [
        FilteringTextInputFormatter.digitsOnly,
      ],
      //控制软键盘输入类型
      keyboardType: TextInputType.number,
      //软键盘回车键图标。
      textInputAction: next(),
      //输入框最大长度。
      maxLength: 5,
      onChanged: (value) {
        //不为空才赋值
        if (value.isNotEmpty) {
          _passwordBean.orders = int.parse(value);
        }
      },
    );
  }

  ///邮箱输入框
  TextFormField _emailTextField() {
    return TextFormField(
      //输入框样式及内字体
      controller: _email,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        icon: const Icon(Icons.email),
        labelText: LanguageText.email.tr,
        counterText: '',
        border: const UnderlineInputBorder(),
        hintText: LanguageText.email.tr,
      ),
      //是否自动获取焦点。
      autofocus: false,
      //输入框最大长度。
      maxLength: 128,
      //控制软键盘输入类型
      keyboardType: TextInputType.emailAddress,
      //软键盘回车键图标。
      textInputAction: next(),
      //输入触发事件
      onChanged: (value) {
        _passwordBean.email = value;
      },
    );
  }

  ///网络地址输入框
  TextFormField _networkAddressTextField() {
    return TextFormField(
//输入框样式及内字体
      controller: _networkAddress,
      readOnly: widget.readOnly,
      decoration: InputDecoration(
        icon: const Icon(Icons.explore),
        labelText: LanguageText.networkAddress.tr,
        counterText: '',
        border: const UnderlineInputBorder(),
        hintText: LanguageText.networkAddress.tr,
      ),
      //是否自动获取焦点。
      autofocus: false,
      //输入框最大长度。
      maxLength: 128,
      //控制软键盘输入类型
      keyboardType: TextInputType.emailAddress,
      //软键盘回车键图标。
      //       textInputAction: next(),
      //输入触发事件
      onChanged: (value) {
        _passwordBean.networkAddress = value;
      },
    );
  }

  ///密码夹选择框
  DropdownButtonFormField _folderDropdownButtonFormField(BuildContext context) {
    return DropdownButtonFormField(
      key: _folderDropdownButtonFormFieldKey,
      value: widget.isAdd ? null : _folderId,
      // readOnly:true,
      decoration: InputDecoration(
        // enabled : !widget.readOnly,
        icon: const Icon(Icons.folder),
        labelText: LanguageText.passwordFolder.tr,
        border: const UnderlineInputBorder(),
        hintText: LanguageText.passwordFolder.tr,
      ),
      validator: (value) =>
          inputValidator(value, LanguageText.passwordFolder.tr),
      // hint: const Text("请选择一个城市"),
      items: _folderItemList(context),
      //根据条件禁用选择
      onChanged: widget.readOnly
          ? null
          : (value) {
              debugPrint(value);
              _passwordBean.folderId = value;
            },
      isExpanded: true,
    );
  }

  ///循环封装下拉列表对象
  List<DropdownMenuItem> _folderItemList(BuildContext context) {
    List<FolderBean> list = FolderService().getFolderList(context);
    List<DropdownMenuItem> dropdownMenuItemList = [];
    for (FolderBean folderBean in list) {
      dropdownMenuItemList.add(_folderItem(folderBean));
    }

    return dropdownMenuItemList;
  }

  ///下拉列表选择框
  DropdownMenuItem _folderItem(FolderBean folderBean) {
    return DropdownMenuItem(
      value: folderBean.id.toString(),
      child: Text(folderBean.name),
    );
  }
}
