import 'package:convida/app/shared/global/constants.dart';

final _authotory = kURL;

Uri buildUri(final String _path) {
  String uriStr = _authotory + _path;
  Uri uri = Uri.parse(uriStr);
  print(uri);
  return uri;
  // if (isConnectionSecure()) {
  //   final _uri = Uri.https(_authotory, _path);
  //   print(_uri);
  //   return _uri;
  // } else {
  //   final _uri = Uri.http(_authotory, _path);
  //   print(_uri);
  //   return _uri;
  // }
}

Uri buildUriParams(final String _path, final Map<String, dynamic> _params) {
  String uriStr = _authotory + _path;
  Uri uri = Uri.parse(uriStr).replace(queryParameters: _params);
  print(uri);
  return uri;

  // if (isConnectionSecure()) {
  //   final _uri = Uri.https(_authotory, _path, _params);
  //   return _uri;
  // } else {
  //   final _uri = Uri.http(_authotory, _path, _params);
  //   return _uri;
  // }
}

bool isConnectionSecure() {
  if (_authotory.contains("https:"))
    return true;
  else
    return false;
}