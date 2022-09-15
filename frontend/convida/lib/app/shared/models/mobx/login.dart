import 'package:mobx/mobx.dart';
part 'login.g.dart';

class Login = _LoginBase with _$Login;

abstract class _LoginBase with Store {
  @observable
  String user;
  @action
  setUser(String value) => user = value;

  @observable
  String password;
  @action
  setPassword(String value) => password = value;
}