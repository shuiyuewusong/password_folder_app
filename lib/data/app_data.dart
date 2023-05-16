import 'package:flutter/cupertino.dart';

class AppData extends ChangeNotifier {
  static bool _initDate = false;

  bool get getInitData {
    return _initDate;
  }

  AppData() {
    debugPrint('AppData:new');
    // initRun(context);
  }

  void setTrue() {
    _initDate = true;
    debugPrint('AppData:true data');
    notifyListeners();
  }

  void update(bool bo) {
    _initDate = bo;
    debugPrint('AppData:update data');
    notifyListeners();
  }

  @override
  void dispose() {
    super.dispose();
    debugPrint('AppData:disposed');
  }
}
