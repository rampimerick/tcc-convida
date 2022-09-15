// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Profile on _ProfileBase, Store {
  final _$nameAtom = Atom(name: '_ProfileBase.name');

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

  final _$lastNameAtom = Atom(name: '_ProfileBase.lastName');

  @override
  String get lastName {
    _$lastNameAtom.context.enforceReadPolicy(_$lastNameAtom);
    _$lastNameAtom.reportObserved();
    return super.lastName;
  }

  @override
  set lastName(String value) {
    _$lastNameAtom.context.conditionallyRunInAction(() {
      super.lastName = value;
      _$lastNameAtom.reportChanged();
    }, _$lastNameAtom, name: '${_$lastNameAtom.name}_set');
  }

  final _$passwordAtom = Atom(name: '_ProfileBase.password');

  @override
  String get password {
    _$passwordAtom.context.enforceReadPolicy(_$passwordAtom);
    _$passwordAtom.reportObserved();
    return super.password;
  }

  @override
  set password(String value) {
    _$passwordAtom.context.conditionallyRunInAction(() {
      super.password = value;
      _$passwordAtom.reportChanged();
    }, _$passwordAtom, name: '${_$passwordAtom.name}_set');
  }

  final _$newPasswordAtom = Atom(name: '_ProfileBase.newPassword');

  @override
  String get newPassword {
    _$newPasswordAtom.context.enforceReadPolicy(_$newPasswordAtom);
    _$newPasswordAtom.reportObserved();
    return super.newPassword;
  }

  @override
  set newPassword(String value) {
    _$newPasswordAtom.context.conditionallyRunInAction(() {
      super.newPassword = value;
      _$newPasswordAtom.reportChanged();
    }, _$newPasswordAtom, name: '${_$newPasswordAtom.name}_set');
  }

  final _$confirmPasswordAtom = Atom(name: '_ProfileBase.confirmPassword');

  @override
  String get confirmPassword {
    _$confirmPasswordAtom.context.enforceReadPolicy(_$confirmPasswordAtom);
    _$confirmPasswordAtom.reportObserved();
    return super.confirmPassword;
  }

  @override
  set confirmPassword(String value) {
    _$confirmPasswordAtom.context.conditionallyRunInAction(() {
      super.confirmPassword = value;
      _$confirmPasswordAtom.reportChanged();
    }, _$confirmPasswordAtom, name: '${_$confirmPasswordAtom.name}_set');
  }

  final _$emailAtom = Atom(name: '_ProfileBase.email');

  @override
  String get email {
    _$emailAtom.context.enforceReadPolicy(_$emailAtom);
    _$emailAtom.reportObserved();
    return super.email;
  }

  @override
  set email(String value) {
    _$emailAtom.context.conditionallyRunInAction(() {
      super.email = value;
      _$emailAtom.reportChanged();
    }, _$emailAtom, name: '${_$emailAtom.name}_set');
  }

  final _$birthAtom = Atom(name: '_ProfileBase.birth');

  @override
  String get birth {
    _$birthAtom.context.enforceReadPolicy(_$birthAtom);
    _$birthAtom.reportObserved();
    return super.birth;
  }

  @override
  set birth(String value) {
    _$birthAtom.context.conditionallyRunInAction(() {
      super.birth = value;
      _$birthAtom.reportChanged();
    }, _$birthAtom, name: '${_$birthAtom.name}_set');
  }

  final _$_ProfileBaseActionController = ActionController(name: '_ProfileBase');

  @override
  dynamic changeName(String value) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction();
    try {
      return super.changeName(value);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLastName(String value) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction();
    try {
      return super.changeLastName(value);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(String value) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction();
    try {
      return super.changePassword(value);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeNewPassword(String value) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction();
    try {
      return super.changeNewPassword(value);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeConfirmPassword(String value) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction();
    try {
      return super.changeConfirmPassword(value);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEmail(String value) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction();
    try {
      return super.changeEmail(value);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeBirth(String value) {
    final _$actionInfo = _$_ProfileBaseActionController.startAction();
    try {
      return super.changeBirth(value);
    } finally {
      _$_ProfileBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'name: ${name.toString()},lastName: ${lastName.toString()},password: ${password.toString()},newPassword: ${newPassword.toString()},confirmPassword: ${confirmPassword.toString()},email: ${email.toString()},birth: ${birth.toString()}';
    return '{$string}';
  }
}
