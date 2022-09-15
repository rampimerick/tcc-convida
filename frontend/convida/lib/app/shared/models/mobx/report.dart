import 'package:mobx/mobx.dart';

part 'report.g.dart';

class ReportModel = _ReportModelBase with _$ReportModel;

abstract class _ReportModelBase with Store {

  _ReportModelBase({this.description, this.author, this.ignored, this.active, this.id, this.nbrReports});

  @observable
  String description;

  @observable
  String author;

  @observable
  bool ignored;

  @observable
  bool active;
  
  @observable
  String id;

  @observable
  int nbrReports;


  @action
  setDescription(String value) => description = value;

  @action
  setAuthor(String value) => author = value;

  @action
  setIgnored(bool value) => ignored = value;

  @action
  setActive(bool value) => active = value;

  @action
  setId(String value) => id = value;

  @action
  setNbrReports(int value) => nbrReports = value;

}