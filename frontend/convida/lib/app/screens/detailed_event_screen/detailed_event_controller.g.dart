// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detailed_event_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$DetailedEventController on _DetailedEventControllerBase, Store {
  final _$reportAtom = Atom(name: '_DetailedEventControllerBase.report');

  @override
  String get report {
    _$reportAtom.reportRead();
    return super.report;
  }

  @override
  set report(String value) {
    _$reportAtom.reportWrite(value, super.report, () {
      super.report = value;
    });
  }

  final _$favoriteAtom = Atom(name: '_DetailedEventControllerBase.favorite');

  @override
  bool get favorite {
    _$favoriteAtom.reportRead();
    return super.favorite;
  }

  @override
  set favorite(bool value) {
    _$favoriteAtom.reportWrite(value, super.favorite, () {
      super.favorite = value;
    });
  }

  final _$presenceAtom = Atom(name: '_DetailedEventControllerBase.presence');

  @override
  bool get presence {
    _$presenceAtom.reportRead();
    return super.presence;
  }

  @override
  set presence(bool value) {
    _$presenceAtom.reportWrite(value, super.presence, () {
      super.presence = value;
    });
  }

  final _$authorAtom = Atom(name: '_DetailedEventControllerBase.author');

  @override
  User get author {
    _$authorAtom.reportRead();
    return super.author;
  }

  @override
  set author(User value) {
    _$authorAtom.reportWrite(value, super.author, () {
      super.author = value;
    });
  }

  final _$_DetailedEventControllerBaseActionController =
  ActionController(name: '_DetailedEventControllerBase');

  @override
  dynamic setReport(dynamic value) {
    final _$actionInfo = _$_DetailedEventControllerBaseActionController
        .startAction(name: '_DetailedEventControllerBase.setReport');
    try {
      return super.setReport(value);
    } finally {
      _$_DetailedEventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setFavorite(bool value) {
    final _$actionInfo = _$_DetailedEventControllerBaseActionController
        .startAction(name: '_DetailedEventControllerBase.setFavorite');
    try {
      return super.setFavorite(value);
    } finally {
      _$_DetailedEventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic setPresence(bool value) {
    final _$actionInfo = _$_DetailedEventControllerBaseActionController
        .startAction(name: '_DetailedEventControllerBase.setPresence');
    try {
      return super.setPresence(value);
    } finally {
      _$_DetailedEventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
report: ${report},
favorite: ${favorite},
presence: ${presence},
author: ${author}
    ''';
  }
}
