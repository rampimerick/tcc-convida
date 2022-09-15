import 'package:mobx/mobx.dart';
part 'signup.g.dart';

class Signup = _SignupBase with _$Signup;

abstract class _SignupBase with Store {
  @observable
  String grr;
  @action
  changeGrr(String value) => grr = value;

  @observable
  String name;
  @action
  changeName(String value) => name = value;
  
  @observable
  String lastName;
  @action
  changeLastName(String value) => lastName = value;
  
  @observable
  String password;
  @action
  changePassword(String value) => password = value;

  @observable
  String confirmPassword;
  @action
  changeConfirmPassword(String value) => confirmPassword = value;
  
  @observable
  String email;
  @action
  changeEmail(String value) => email = value;
  
  @observable
  String birth;
  @action
  changeBirth(String value) => birth = value;

}