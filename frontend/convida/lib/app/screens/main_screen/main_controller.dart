//
// import 'dart:convert';
// import 'package:convida/app/shared/models/user.dart';
// import 'package:http/http.dart' as http;
// import 'package:convida/app/shared/DAO/util_requisitions.dart';
// import 'package:convida/app/shared/global/constants.dart';
// import 'package:convida/app/shared/util/dialogs_widget.dart';
// import 'package:flutter_secure_storage/flutter_secure_storage.dart';
//
// Future<String> getUserProfile(user, context) async {
//
//   String _url = kURL;
//   final _save = FlutterSecureStorage();
//   final _token = await _save.read(key: "token");
//   bool admin;
//
//   dynamic response;
//   String request;
//   try {
//     final userId = await _save.read(key: "userId");
//
//     request = "$_url/users/$userId";
//     var mapHeaders = getHeaderToken(_token);
//
//     response = await http.get(Uri.parse(request), headers: mapHeaders);
//     printRequisition(request, response.statusCode, "Get User Profile");
//     if ((response.statusCode == 200) || (response.statusCode == 201)) {
//       user = User.fromJson(jsonDecode(response.body));
//       admin = user.adm;
//       print("isAdmin: ${user.adm}");
//     } else {
//       errorStatusCode(
//           response.statusCode, context, "Erro ao Carregar Perfil");
//     }
//     return "Success";
//
//   } catch (e) {
//     showError("Erro desconhecido ao carregar Usuario", "Erro: $e", context);
//     return "Failed";
//   }
// }