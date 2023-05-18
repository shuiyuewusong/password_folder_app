import 'package:password_folder_app/i18n/i18n.dart';
import 'package:password_folder_app/i18n/language_type.dart';
import 'package:get/get.dart';

///语言映射值返回类
class MyLanguageTr extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        LanguageType.en: {
          ///home_page
          LanguageText.title: LanguageText.title,

          ///app_settings
          LanguageText.appSettings: LanguageText.appSettings,
          LanguageText.basicSettings: LanguageText.basicSettings,
          LanguageText.folderSettings: LanguageText.folderSettings,
          LanguageText.manuallySyncSettings: LanguageText.manuallySyncSettings,
          LanguageText.autoSyncSettings: LanguageText.autoSyncSettings,

          ///数据
          LanguageText.data: LanguageText.data,
          LanguageText.importData: LanguageText.importData,
          LanguageText.exportData: LanguageText.exportData,

          /// Basic Settings
          /// theme Settings
          LanguageText.themeSettings: LanguageText.themeSettings,
          LanguageText.themeColorSettings: LanguageText.themeColorSettings,
          LanguageText.lightTheme: LanguageText.lightTheme,
          LanguageText.darkTheme: LanguageText.darkTheme,
          LanguageText.autoTheme: LanguageText.autoTheme,

          ///language Settings
          LanguageText.languageSettings: LanguageText.languageSettings,
          LanguageText.automaticAcquisition: LanguageText.automaticAcquisition,
          LanguageText.english: LanguageText.english,
          LanguageText.chinese: LanguageText.chinese,

          ///home_folder_list
          LanguageText.allPassword: LanguageText.allPassword,

          ///password_form
          LanguageText.name: LanguageText.name,
          LanguageText.account: LanguageText.account,
          LanguageText.password: LanguageText.password,
          LanguageText.notes: LanguageText.notes,
          LanguageText.order: LanguageText.order,
          LanguageText.theSmallerTheNumberTheHigherTheOrder:
              LanguageText.theSmallerTheNumberTheHigherTheOrder,
          LanguageText.email: LanguageText.email,
          LanguageText.networkAddress: LanguageText.networkAddress,
          LanguageText.passwordFolder: LanguageText.passwordFolder,
          LanguageText.cannotBeEmpty: LanguageText.cannotBeEmpty,

          ///password_add
          LanguageText.titleCreate: LanguageText.titleCreate,
          LanguageText.create: LanguageText.create,

          ///password_Edit
          LanguageText.titleEdit: LanguageText.titleEdit,
          LanguageText.edit: LanguageText.edit,

          ///ALL
          LanguageText.remind: LanguageText.remind,
          LanguageText.delete: LanguageText.delete,
          LanguageText.cancel: LanguageText.cancel,
          LanguageText.deleteComplete: LanguageText.deleteComplete,
          LanguageText.save: LanguageText.save,
          LanguageText.saveComplete: LanguageText.saveComplete,
          LanguageText.pleaseCompleteTheContentToSave:
              LanguageText.pleaseCompleteTheContentToSave,
          LanguageText.whetherToDeleteThePasswordFolder:
              LanguageText.whetherToDeleteThePasswordFolder,
          LanguageText.whetherToDeleteThePassword:
              LanguageText.whetherToDeleteThePassword,
          LanguageText.unableToDeletePasswordFolderWithPassword:
              LanguageText.unableToDeletePasswordFolderWithPassword,
          LanguageText.ok: LanguageText.ok,
          LanguageText.importDataExceptionDataUnavailable:
              LanguageText.importDataExceptionDataUnavailable,
          LanguageText.importSuccessfully: LanguageText.importSuccessfully,
          LanguageText.exportSuccessfully: LanguageText.exportSuccessfully,
          LanguageText.passwordCopiedToClipboard:
              LanguageText.passwordCopiedToClipboard,
          LanguageText.accountCopiedToClipboard:
              LanguageText.accountCopiedToClipboard,
          LanguageText.message: LanguageText.message,
          LanguageText.example: LanguageText.example,
        },
        LanguageType.zh: {
          ///home_page
          LanguageText.title: '密码册',

          ///app_settings
          LanguageText.appSettings: 'APP 设置',
          LanguageText.basicSettings: '基础设置',
          LanguageText.folderSettings: '文件夹设置',
          LanguageText.manuallySyncSettings: '手动同步数据',
          LanguageText.autoSyncSettings: '自动同步数据',

          ///数据
          LanguageText.data: '数据',
          LanguageText.importData: '导入数据',
          LanguageText.exportData: '导出数据',

          /// Basic Settings
          /// theme Settings
          LanguageText.themeSettings: '主题设置',
          LanguageText.themeColorSettings: '主题色设置',
          LanguageText.lightTheme: '明亮主题',
          LanguageText.darkTheme: '暗黑主题',
          LanguageText.autoTheme: '自动主题',

          ///language Settings
          LanguageText.languageSettings: '语言设置',
          LanguageText.automaticAcquisition: '自动获取',
          LanguageText.english: LanguageText.english,
          LanguageText.chinese: LanguageText.chinese,

          ///home_folder_list
          LanguageText.allPassword: '全部数据',

          ///password_form
          LanguageText.name: '名称',
          LanguageText.account: '账户',
          LanguageText.password: '密码',
          LanguageText.notes: '备注',
          LanguageText.order: '排序',
          LanguageText.theSmallerTheNumberTheHigherTheOrder: '数字越小排序越前,默认0.',
          LanguageText.email: '邮箱',
          LanguageText.networkAddress: '网络地址',
          LanguageText.passwordFolder: '密码夹',
          LanguageText.cannotBeEmpty: '不能为空!',

          ///password_add
          LanguageText.titleCreate: '新建',
          LanguageText.create: '新建',

          ///password_Edit
          LanguageText.titleEdit: '编辑',
          LanguageText.edit: '编辑',

          ///ALl
          LanguageText.remind: '提醒',
          LanguageText.delete: '删除',
          LanguageText.cancel: '取消',
          LanguageText.deleteComplete: '删除完成',
          LanguageText.save: '保存',
          LanguageText.saveComplete: '保存完成',
          LanguageText.pleaseCompleteTheContentToSave: '请补全内容方可保存.',
          LanguageText.whetherToDeleteThePasswordFolder: '是否删除该密码夹.',
          LanguageText.whetherToDeleteThePassword: '是否删除该密码.',
          LanguageText.unableToDeletePasswordFolderWithPassword: '无法删除带密码的密码夹',
          LanguageText.ok: '好的',
          LanguageText.importDataExceptionDataUnavailable: '导入数据异常,数据不可用',
          LanguageText.importSuccessfully: '导入成功',
          LanguageText.exportSuccessfully: '导出成功,数据已复制至剪贴板',
          LanguageText.passwordCopiedToClipboard: '密码已复制到剪贴版',
          LanguageText.accountCopiedToClipboard: '账户已复制到剪贴板',

          LanguageText.message: '消息',
          LanguageText.example: '示例',
        }
      };
}
