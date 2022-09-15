import 'package:mobx/mobx.dart';
part 'event_report.g.dart';

class EventReportModel = _EventReportModelBase with _$EventReportModel;

abstract class _EventReportModelBase with Store {

  _EventReportModelBase({this.name, this.type ,this.check});

  @observable
  String name;

  @observable
  String type;

  @observable
  bool check;

  @action
  setTitle(String value) => name = value;

  @action
  setType(String value) => type = value;  
  
  @action
  setCheck(bool value) => check = value;  
}