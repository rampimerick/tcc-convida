import 'package:mobx/mobx.dart';
part 'profile.g.dart';

class Profile = _ProfileBase with _$Profile;

abstract class _ProfileBase with Store {
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
  String newPassword;
  @action
  changeNewPassword(String value) => newPassword = value;

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