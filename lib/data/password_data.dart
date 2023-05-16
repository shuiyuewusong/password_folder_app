import 'package:password_folder_app/bean/password_bean.dart';
import 'package:flutter/cupertino.dart';

class PasswordData extends ChangeNotifier {
  late List<PasswordBean> _passwordList;

  List<PasswordBean> get getPasswordList {
    return _passwordList;
  }

  PasswordData() {
    _passwordList = [];
    debugPrint('PasswordData:new');
  }

  void update(List<PasswordBean> passwordList) {
    _passwordList = passwordList;
    debugPrint('PasswordData:update data');
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('PasswordData:disposed');
  }
}
