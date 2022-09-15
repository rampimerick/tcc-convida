// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'report_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ReportController on _ReportControllerBase, Store {
  final _$listItemsAtom = Atom(name: '_ReportControllerBase.listItems');

  @override
  List<Event> get listItems {
    _$listItemsAtom.reportRead();
    return super.listItems;
  }

  @override
  set listItems(List<Event> value) {
    _$listItemsAtom.reportWrite(value, super.listItems, () {
      super.listItems = value;
    });
  }

  final _$_ReportControllerBaseActionController =
  ActionController(name: '_ReportControllerBase');

  @override
  dynamic setListItems(List<Event> value) {
    final _$actionInfo = _$_ReportControllerBaseActionController.startAction(
        name: '_ReportControllerBase.setListItems');
    try {
      return super.setListItems(value);
    } finally {
      _$_ReportControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
listItems: ${listItems}
    ''';
  }
}
