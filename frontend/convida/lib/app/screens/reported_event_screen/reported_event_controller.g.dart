// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'reported_event_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportedEventController on _ReportedEventControllerBase, Store {
  final _$loadingAtom = Atom(name: '_ReportedEventControllerBase.loading');

  @override
  bool get loading {
    _$loadingAtom.reportRead();
    return super.loading;
  }

  @override
  set loading(bool value) {
    _$loadingAtom.reportWrite(value, super.loading, () {
      super.loading = value;
    });
  }

  final _$listReportsAtom =
  Atom(name: '_ReportedEventControllerBase.listReports');

  @override
  ObservableList<dynamic> get listReports {
    _$listReportsAtom.reportRead();
    return super.listReports;
  }

  @override
  set listReports(ObservableList<dynamic> value) {
    _$listReportsAtom.reportWrite(value, super.listReports, () {
      super.listReports = value;
    });
  }

  final _$_ReportedEventControllerBaseActionController =
  ActionController(name: '_ReportedEventControllerBase');

  @override
  dynamic removeReport(ReportModel report, BuildContext context) {
    final _$actionInfo = _$_ReportedEventControllerBaseActionController
        .startAction(name: '_ReportedEventControllerBase.removeReport');
    try {
      return super.removeReport(report, context);
    } finally {
      _$_ReportedEventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
listReports: ${listReports}
    ''';
  }
}
