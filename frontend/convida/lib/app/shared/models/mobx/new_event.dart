import 'package:mobx/mobx.dart';
part 'new_event.g.dart';

class NewEvent = _NewEventBase with _$NewEvent;

abstract class _NewEventBase with Store {
  @observable
  String name;
  @action
  setName(String value) => name = value;

  @observable
  String target;
  @action
  setTarget(String value) => target = value;

  @observable
  String desc;
  @action
  setDesc(String value) => desc = value;

  @observable
  bool online;
  @action
  setOnline(bool value) => online = value;

  @observable
  String address;
  @action
  setAddress(String value) => address = value;

  @observable
  String complement;
  @action
  setComplement(String value) => complement = value;

  @observable
  String link;
  @action
  setLink(String value) => link = value;

  @observable
  String type;
  @action
  setType(String value) => type = value;

  @observable
  String hrStart;
  @action
  setHrStart(String value) => hrStart = value;

  @observable
  String hrEnd;
  @action
  setHrEnd(String value) => hrEnd = value;

  @observable
  String dateStart;
  @action
  setDateStart(String value) => dateStart = value;

  @observable
  String dateEnd;
  @action
  setDateEnd(String value) => dateEnd = value;

  @observable
  String subStart;
  @action
  setSubStart(String value) => subStart = value;

  @observable
  String subEnd;
  @action
  setSubEnd(String value) => subEnd  = value;
}