// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_model.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$AdminModel on _AdminModelBase, Store {
  final _$nameAtom = Atom(name: '_AdminModelBase.name');

  @override
  String get name {
    _$nameAtom.reportRead();
    return super.name;
  }

  @override
  set name(String value) {
    _$nameAtom.reportWrite(value, super.name, () {
      super.name = value;
    });
  }

  final _$lastNameAtom = Atom(name: '_AdminModelBase.lastName');

  @override
  String get lastName {
    _$lastNameAtom.reportRead();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.reportWrite(value, super.lastName, () {
      super.lastName = value;
    });
  }

  final _$idAtom = Atom(name: '_AdminModelBase.id');

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

  final _$emailAtom = Atom(name: '_AdminModelBase.email');

  @override
  String get email {
    _$emailAtom.reportRead();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.reportWrite(value, super.email, () {
      super.email = value;
    });
  }

  final _$admAtom = Atom(name: '_AdminModelBase.adm');

  @override
  bool get adm {
    _$admAtom.reportRead();
    return super.adm;
  }

  @override
  set adm(bool value) {
    _$admAtom.reportWrite(value, super.adm, () {
      super.adm = value;
    });
  }

  final _$_AdminModelBaseActionController =
  ActionController(name: '_AdminModelBase');

  @override
  dynamic setDescription(String value) {
    final _$actionInfo = _$_AdminModelBaseActionController.startAction(
        name: '_AdminModelBase.setDescription');
    try {
      return super.setDescription(value);
    } finally {
      _$_AdminModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAuthor(String value) {
    final _$actionInfo = _$_AdminModelBaseActionController.startAction(
        name: '_AdminModelBase.setAuthor');
    try {
      return super.setAuthor(value);
    } finally {
      _$_AdminModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setIgnored(String value) {
    final _$actionInfo = _$_AdminModelBaseActionController.startAction(
        name: '_AdminModelBase.setIgnored');
    try {
      return super.setIgnored(value);
    } finally {
      _$_AdminModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setId(String value) {
    final _$actionInfo = _$_AdminModelBaseActionController.startAction(
        name: '_AdminModelBase.setId');
    try {
      return super.setId(value);
    } finally {
      _$_AdminModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setAdm(bool value) {
    final _$actionInfo = _$_AdminModelBaseActionController.startAction(
        name: '_AdminModelBase.setAdm');
    try {
      return super.setAdm(value);
    } finally {
      _$_AdminModelBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
name: ${name},
lastName: ${lastName},
id: ${id},
email: ${email},
adm: ${adm}
    ''';
  }
}
