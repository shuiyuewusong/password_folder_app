import 'package:password_folder_app/bean/folder_bean.dart';
import 'package:password_folder_app/bean/global_settings.dart';
import 'package:password_folder_app/bean/password_bean.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

const _name = "isar1";

class IsarDbUtils {
  IsarDbUtils._privateConstructor();

  //
  static final IsarDbUtils _isar = IsarDbUtils._privateConstructor();

  static IsarDbUtils get getIsar {
    return _isar;
  }

  static late Isar _isarInstance;

  static Isar get getIsarInstance => _isarInstance;

  Future<bool> init() async {
    final d1 = await getApplicationDocumentsDirectory();
    final d2 = await Isar.open(
      name: _name,
      [FolderBeanSchema, PasswordBeanSchema, GlobalSettingsSchema],
      inspector: false,
      directory: d1.path,
    );
    _isarInstance = d2;
    return true;
  }
}
