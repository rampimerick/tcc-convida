// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'event_report.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$EventReportModel on _EventReportModelBase, Store {
  final _$nameAtom = Atom(name: '_EventReportModelBase.name');

  @override
  String get name {
    _$nameAtom.context.enforceReadPolicy(_$nameAtom);
    _$nameAtom.reportObserved();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.context.conditionallyRunInAction(() {
      super.name = value;
      _$nameAtom.reportChanged();
    }, _$nameAtom, name: '${_$nameAtom.name}_set');
  }

  final _$typeAtom = Atom(name: '_EventReportModelBase.type');

  @override
  String get type {
    _$typeAtom.context.enforceReadPolicy(_$typeAtom);
    _$typeAtom.reportObserved();
    return super.type;
  }

  @override
  set type(String value) {
    _$typeAtom.context.conditionallyRunInAction(() {
      super.type = value;
      _$typeAtom.reportChanged();
    }, _$typeAtom, name: '${_$typeAtom.name}_set');
  }

  final _$checkAtom = Atom(name: '_EventReportModelBase.check');

  @override
  bool get check {
    _$checkAtom.context.enforceReadPolicy(_$checkAtom);
    _$checkAtom.reportObserved();
    return super.check;
  }

  @override
  set check(bool value) {
    _$checkAtom.context.conditionallyRunInAction(() {
      super.check = value;
      _$checkAtom.reportChanged();
    }, _$checkAtom, name: '${_$checkAtom.name}_set');
  }

  final _$_EventReportModelBaseActionController =
      ActionController(name: '_EventReportModelBase');

  @override
  dynamic setTitle(String value) {
    final _$actionInfo = _$_EventReportModelBaseActionController.startAction();
    try {
      return super.setTitle(value);
    } finally {
      _$_EventReportModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setType(String value) {
    final _$actionInfo = _$_EventReportModelBaseActionController.startAction();
    try {
      return super.setType(value);
    } finally {
      _$_EventReportModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setCheck(bool value) {
    final _$actionInfo = _$_EventReportModelBaseActionController.startAction();
    try {
      return super.setCheck(value);
    } finally {
      _$_EventReportModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'name: ${name.toString()},type: ${type.toString()},check: ${check.toString()}';
    return '{$string}';
  }
}
