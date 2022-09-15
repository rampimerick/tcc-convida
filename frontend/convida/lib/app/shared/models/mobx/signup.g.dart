// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'signup.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$Signup on _SignupBase, Store {
  final _$grrAtom = Atom(name: '_SignupBase.grr');

  @override
  String get grr {
    _$grrAtom.context.enforceReadPolicy(_$grrAtom);
    _$grrAtom.reportObserved();
    return super.grr;
  }

  @override
  set grr(String value) {
    _$grrAtom.context.conditionallyRunInAction(() {
      super.grr = value;
      _$grrAtom.reportChanged();
    }, _$grrAtom, name: '${_$grrAtom.name}_set');
  }

  final _$nameAtom = Atom(name: '_SignupBase.name');

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

  final _$lastNameAtom = Atom(name: '_SignupBase.lastName');

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

  final _$passwordAtom = Atom(name: '_SignupBase.password');

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

  final _$confirmPasswordAtom = Atom(name: '_SignupBase.confirmPassword');

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

  final _$emailAtom = Atom(name: '_SignupBase.email');

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

  final _$birthAtom = Atom(name: '_SignupBase.birth');

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

  final _$_SignupBaseActionController = ActionController(name: '_SignupBase');

  @override
  dynamic changeGrr(String value) {
    final _$actionInfo = _$_SignupBaseActionController.startAction();
    try {
      return super.changeGrr(value);
    } finally {
      _$_SignupBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeName(String value) {
    final _$actionInfo = _$_SignupBaseActionController.startAction();
    try {
      return super.changeName(value);
    } finally {
      _$_SignupBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeLastName(String value) {
    final _$actionInfo = _$_SignupBaseActionController.startAction();
    try {
      return super.changeLastName(value);
    } finally {
      _$_SignupBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changePassword(String value) {
    final _$actionInfo = _$_SignupBaseActionController.startAction();
    try {
      return super.changePassword(value);
    } finally {
      _$_SignupBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeConfirmPassword(String value) {
    final _$actionInfo = _$_SignupBaseActionController.startAction();
    try {
      return super.changeConfirmPassword(value);
    } finally {
      _$_SignupBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeEmail(String value) {
    final _$actionInfo = _$_SignupBaseActionController.startAction();
    try {
      return super.changeEmail(value);
    } finally {
      _$_SignupBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  dynamic changeBirth(String value) {
    final _$actionInfo = _$_SignupBaseActionController.startAction();
    try {
      return super.changeBirth(value);
    } finally {
      _$_SignupBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    final string =
        'grr: ${grr.toString()},name: ${name.toString()},lastName: ${lastName.toString()},password: ${password.toString()},confirmPassword: ${confirmPassword.toString()},email: ${email.toString()},birth: ${birth.toString()}';
    return '{$string}';
  }
}
