import 'package:isar/isar.dart';

/// 如果类有更新需要使用代码生成器重新生成:flutter pub run build_runner build
part 'password_bean.g.dart';

@collection
class PasswordBean {
  ///主键 1
  Id id = Isar.autoIncrement; // 你也可以用 id = null 来表示 id 是自增的

  ///名称 2
  late String name;

  ///排序 3
  late int orders;

  /// 密码夹id 4
  late String folderId;

  ///备注 5
  late String notes;

  ///账户 6
  late String account;

  ///密码 7
  late String password;

  /// 电子邮箱 8
  late String email;

  ///网络地址 9
  late String networkAddress;

  ///图标 10
  late String icon;

  ///静态变量
  static const String beanPassword = 'passwordBean';
  static const String _passwordId = 'id';
  static const String _passwordName = 'name';
  static const String _passwordOrders = 'orders';
  static const String _passwordFolderId = 'passwordFolderId';
  static const String _passwordNotes = 'notes';
  static const String _passwordAccount = 'account';
  static const String _passwordPassword = 'password';
  static const String _passwordEmail = 'email';
  static const String _passwordNetworkAddress = 'networkAddress';
  static const String _passwordIcon = 'icon';

  PasswordBean({
    this.name = '',
    this.orders = 0,
    this.folderId = '',
    this.notes = '',
    this.account = '',
    this.password = '',
    this.email = '',
    this.networkAddress = '',
    this.icon = '',
  }) {}

  clone(PasswordBean passwordBean) {
    PasswordBean p = PasswordBean();
    p.id = passwordBean.id;
    p.name = passwordBean.name;
    p.account = passwordBean.account;
    p.password = passwordBean.password;
    p.notes = passwordBean.notes;
    p.orders = passwordBean.orders;
    p.email = passwordBean.email;
    p.networkAddress = passwordBean.networkAddress;
    p.folderId = passwordBean.folderId;
    p.icon = passwordBean.icon;
    return p;
  }

//{
//     required this.id,
//     required this.name,
//     required this.orders,
//     required this.foldersId,
//     required this.notes,
//     required this.account,
//     required this.password,
//     required this.email,
//     required this.networkAddress,
//     required this.icon,
//   }
  Map<String, dynamic> getMap() {
    return {
      _passwordId: id,
      _passwordName: name,
      _passwordOrders: orders,
      _passwordFolderId: folderId,
      _passwordNotes: notes,
      _passwordAccount: account,
      _passwordPassword: password,
      _passwordEmail: email,
      _passwordNetworkAddress: networkAddress,
      _passwordIcon: icon,
    };
  }

  setMap(Map<String, dynamic> map) {
    id = map[_passwordId];
    name = map[_passwordName];
    orders = map[_passwordOrders];
    folderId = map[_passwordFolderId];
    notes = map[_passwordNotes];
    account = map[_passwordAccount];
    password = map[_passwordPassword];
    email = map[_passwordEmail];
    networkAddress = map[_passwordNetworkAddress];
    icon = map[_passwordIcon];
  }
}
