// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'admin_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewAdminController on _NewAdminControllerBase, Store {
  final _$listItemsAtom = Atom(name: '_NewAdminControllerBase.listItems');

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

  final _$getUsersNameSearchAsyncAction =
  AsyncAction('_NewAdminControllerBase.getUsersNameSearch');

  @override
  Future<List<dynamic>> getUsersNameSearch(
      String search, BuildContext context) {
    return _$getUsersNameSearchAsyncAction
        .run(() => super.getUsersNameSearch(search, context));
  }

  final _$putAdminAsyncAction = AsyncAction('_NewAdminControllerBase.putAdmin');

  @override
  Future<bool> putAdmin(BuildContext context, String userId) {
    return _$putAdminAsyncAction.run(() => super.putAdmin(context, userId));
  }

  @override
  String toString() {
    return '''
listItems: ${listItems}
    ''';
  }
}
