import 'package:flutter_secure_storage/flutter_secure_storage.dart';

Future<bool> checkToken() async {
  final _save = FlutterSecureStorage();
  String _token, _userId;

  _token = await _save.read(key: "token");
  _userId = await _save.read(key: "userId");
  if (_token == null) {
    return false;
  } else {
    return true;
  }
}

Future<String> checkTokenn() async {
  final _save = FlutterSecureStorage();
  String _token;

  _token = await _save.read(key: "token");
 // _userId = await _save.read(key: "userId");

  return _token;
}
