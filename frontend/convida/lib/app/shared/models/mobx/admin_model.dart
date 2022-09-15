import 'package:mobx/mobx.dart';

part 'admin_model.g.dart';

class AdminModel = _AdminModelBase with _$AdminModel;

abstract class _AdminModelBase with Store {
  _AdminModelBase({this.name, this.lastName, this.id, this.email});

  @observable
  String name;

  @observable
  String lastName;

  @observable
  String id;

  @observable
  String email;

  @observable
  bool adm;

  @action
  setDescription(String value) => name = value;

  @action
  setAuthor(String value) => lastName = value;

  @action
  setIgnored(String value) => id = value;

  @action
  setId(String value) => email = value;

  @action
  setAdm(bool value) => adm = value;
}
