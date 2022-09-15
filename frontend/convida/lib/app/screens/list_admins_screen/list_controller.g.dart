// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'list_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$ListAdminController on _ListAdminsControllerBase, Store {
  final _$listItemsAtom = Atom(name: '_ListAdminsControllerBase.listItems');

  @override
  ObservableList<dynamic> get listItems {
    _$listItemsAtom.reportRead();
    return super.listItems;
  }

  @override
  set listItems(ObservableList<dynamic> value) {
    _$listItemsAtom.reportWrite(value, super.listItems, () {
      super.listItems = value;
    });
  }

  final _$getAllAdminsAsyncAction =
  AsyncAction('_ListAdminsControllerBase.getAllAdmins');

  @override
  Future<List<dynamic>> getAllAdmins(BuildContext context) {
    return _$getAllAdminsAsyncAction.run(() => super.getAllAdmins(context));
  }

  final _$removeAdminAsyncAction =
  AsyncAction('_ListAdminsControllerBase.removeAdmin');

  @override
  Future<List<dynamic>> removeAdmin(BuildContext context, String userId) {
    return _$removeAdminAsyncAction
        .run(() => super.removeAdmin(context, userId));
  }

  @override
  String toString() {
    return '''
listItems: ${listItems}
    ''';
  }
}
