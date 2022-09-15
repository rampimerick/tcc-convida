// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportModel on _ReportModelBase, Store {
  final _$descriptionAtom = Atom(name: '_ReportModelBase.description');

  @override
  String get description {
    _$descriptionAtom.reportRead();
    return super.description;
  }

  @override
  set description(String value) {
    _$descriptionAtom.reportWrite(value, super.description, () {
      super.description = value;
    });
  }

  final _$authorAtom = Atom(name: '_ReportModelBase.author');

  @override
  String get author {
    _$authorAtom.reportRead();
    return super.author;
  }

  @override
  set author(String value) {
    _$authorAtom.reportWrite(value, super.author, () {
      super.author = value;
    });
  }

  final _$ignoredAtom = Atom(name: '_ReportModelBase.ignored');

  @override
  bool get ignored {
    _$ignoredAtom.reportRead();
    return super.ignored;
  }

  @override
  set ignored(bool value) {
    _$ignoredAtom.reportWrite(value, super.ignored, () {
      super.ignored = value;
    });
  }

  final _$idAtom = Atom(name: '_ReportModelBase.id');

  @override
  String get id {
    _$idAtom.reportRead();
    return super.id;
  }

  @override
  set id(String value) {
    _$idAtom.reportWrite(value, super.id, () {
      super.id = value;
    });
  }

  final _$nbrReportsAtom = Atom(name: '_ReportModelBase.nbrReports');

  @override
  int get nbrReports {
    _$nbrReportsAtom.reportRead();
    return super.nbrReports;
  }

  @override
  set nbrReports(int value) {
    _$nbrReportsAtom.reportWrite(value, super.nbrReports, () {
      super.nbrReports = value;
    });
  }

  final _$_ReportModelBaseActionController =
  ActionController(name: '_ReportModelBase');

  @override
  dynamic setDescription(String value) {
    final _$actionInfo = _$_ReportModelBaseActionController.startAction(
        name: '_ReportModelBase.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_ReportModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAuthor(String value) {
    final _$actionInfo = _$_ReportModelBaseActionController.startAction(
        name: '_ReportModelBase.setAuthor');
    try {
      return super.setAuthor(value);
    } finally {
      _$_ReportModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIgnored(bool value) {
    final _$actionInfo = _$_ReportModelBaseActionController.startAction(
        name: '_ReportModelBase.setIgnored');
    try {
      return super.setIgnored(value);
    } finally {
      _$_ReportModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setId(String value) {
    final _$actionInfo = _$_ReportModelBaseActionController.startAction(
        name: '_ReportModelBase.setId');
    try {
      return super.setId(value);
    } finally {
      _$_ReportModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setNbrReports(int value) {
    final _$actionInfo = _$_ReportModelBaseActionController.startAction(
        name: '_ReportModelBase.setNbrReports');
    try {
      return super.setNbrReports(value);
    } finally {
      _$_ReportModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
description: ${description},
author: ${author},
ignored: ${ignored},
id: ${id},
nbrReports: ${nbrReports}
    ''';
  }
}
