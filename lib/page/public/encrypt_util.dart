import 'package:encrypt/encrypt.dart';

class EncryptUtil {
  static String exportData(String password, String data) {
    // String data = '今天星期几?';
    final Key key = Key.fromUtf8(password);
    final Encrypter en = Encrypter(AES(key));
    final Encrypted encrypted = en.encrypt(data, iv: IV.fromLength(16));
    return encrypted.base64;
  }

  static String importData(String password, String ciphertext) {
    final Key key = Key.fromUtf8(password);
    final Encrypter en = Encrypter(AES(key));
    final Encrypted encrypted = Encrypted.fromBase64(ciphertext);
    final String data = en.decrypt(encrypted, iv: IV.fromLength(16));
    return data;
  }
}
