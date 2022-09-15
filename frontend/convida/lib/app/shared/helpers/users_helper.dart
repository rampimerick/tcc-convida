import 'dart:convert';
import 'package:convida/app/shared/models/user.dart';
import 'dart:convert';



List<User> parseUsers(String responseBody) {
  final parsedUsers= jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<User> user = parsedUsers.map<User>((json) => User.fromJson(json)).toList();
  return user;
}

List<User> parseUsersAdm(String responseBody) {
  //print(responseBody);
  final parsedUsers= jsonDecode(responseBody).cast<Map<String, dynamic>>();
  List<User> user = parsedUsers.map<User>((json) => User.fromJson(json)).toList();
  //print(user);
  return user;
}

User parseUser(String responseBody) {
  dynamic parsedUser = json.decode(responseBody);
  final User user = User.fromJson(parsedUser);
  print("Entrou no parseUser: $user");
  return user;
}