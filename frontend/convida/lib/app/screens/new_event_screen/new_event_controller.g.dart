// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'new_event_controller.dart';

// **************************************************************************
// StoreGenerator
// **************************************************************************

// ignore_for_file: non_constant_identifier_names, unnecessary_brace_in_string_interps, unnecessary_lambdas, prefer_expression_function_bodies, lines_longer_than_80_chars, avoid_as, avoid_annotating_with_dynamic

mixin _$NewEventController on _NewEventControllerBase, Store {
  Computed<bool> _$isValidComputed;

  @override
  bool get isValid => (_$isValidComputed ??= Computed<bool>(() => super.isValid,
      name: '_NewEventControllerBase.isValid'))
      .value;

  final _$loadingAtom = Atom(name: '_NewEventControllerBase.loading');

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

  final _$newEventAtom = Atom(name: '_NewEventControllerBase.newEvent');

  @override
  NewEvent get newEvent {
    _$newEventAtom.reportRead();
    return super.newEvent;
  }

  @override
  set newEvent(NewEvent value) {
    _$newEventAtom.reportWrite(value, super.newEvent, () {
      super.newEvent = value;
    });
  }

  final _$occurrencesAtom = Atom(name: '_NewEventControllerBase.occurrences');

  @override
  List<Occurrence> get occurrences {
    _$occurrencesAtom.reportRead();
    return super.occurrences;
  }

  @override
  set occurrences(List<Occurrence> value) {
    _$occurrencesAtom.reportWrite(value, super.occurrences, () {
      super.occurrences = value;
    });
  }

  final _$occurrenceOneStartAtom =
  Atom(name: '_NewEventControllerBase.occurrenceOneStart');

  @override
  String get occurrenceOneStart {
    _$occurrenceOneStartAtom.reportRead();
    return super.occurrenceOneStart;
  }

  @override
  set occurrenceOneStart(String value) {
    _$occurrenceOneStartAtom.reportWrite(value, super.occurrenceOneStart, () {
      super.occurrenceOneStart = value;
    });
  }

  final _$occurrenceOneEndAtom =
  Atom(name: '_NewEventControllerBase.occurrenceOneEnd');

  @override
  String get occurrenceOneEnd {
    _$occurrenceOneEndAtom.reportRead();
    return super.occurrenceOneEnd;
  }

  @override
  set occurrenceOneEnd(String value) {
    _$occurrenceOneEndAtom.reportWrite(value, super.occurrenceOneEnd, () {
      super.occurrenceOneEnd = value;
    });
  }

  final _$occurrenceTwoStartAtom =
  Atom(name: '_NewEventControllerBase.occurrenceTwoStart');

  @override
  String get occurrenceTwoStart {
    _$occurrenceTwoStartAtom.reportRead();
    return super.occurrenceTwoStart;
  }

  @override
  set occurrenceTwoStart(String value) {
    _$occurrenceTwoStartAtom.reportWrite(value, super.occurrenceTwoStart, () {
      super.occurrenceTwoStart = value;
    });
  }

  final _$occurrenceTwoEndAtom =
  Atom(name: '_NewEventControllerBase.occurrenceTwoEnd');

  @override
  String get occurrenceTwoEnd {
    _$occurrenceTwoEndAtom.reportRead();
    return super.occurrenceTwoEnd;
  }

  @override
  set occurrenceTwoEnd(String value) {
    _$occurrenceTwoEndAtom.reportWrite(value, super.occurrenceTwoEnd, () {
      super.occurrenceTwoEnd = value;
    });
  }

  final _$occurrenceThreeStartAtom =
  Atom(name: '_NewEventControllerBase.occurrenceThreeStart');

  @override
  String get occurrenceThreeStart {
    _$occurrenceThreeStartAtom.reportRead();
    return super.occurrenceThreeStart;
  }

  @override
  set occurrenceThreeStart(String value) {
    _$occurrenceThreeStartAtom.reportWrite(value, super.occurrenceThreeStart,
            () {
          super.occurrenceThreeStart = value;
        });
  }

  final _$occurrenceThreeEndAtom =
  Atom(name: '_NewEventControllerBase.occurrenceThreeEnd');

  @override
  String get occurrenceThreeEnd {
    _$occurrenceThreeEndAtom.reportRead();
    return super.occurrenceThreeEnd;
  }

  @override
  set occurrenceThreeEnd(String value) {
    _$occurrenceThreeEndAtom.reportWrite(value, super.occurrenceThreeEnd, () {
      super.occurrenceThreeEnd = value;
    });
  }

  final _$occurrenceFourStartAtom =
  Atom(name: '_NewEventControllerBase.occurrenceFourStart');

  @override
  String get occurrenceFourStart {
    _$occurrenceFourStartAtom.reportRead();
    return super.occurrenceFourStart;
  }

  @override
  set occurrenceFourStart(String value) {
    _$occurrenceFourStartAtom.reportWrite(value, super.occurrenceFourStart, () {
      super.occurrenceFourStart = value;
    });
  }

  final _$occurrenceFourEndAtom =
  Atom(name: '_NewEventControllerBase.occurrenceFourEnd');

  @override
  String get occurrenceFourEnd {
    _$occurrenceFourEndAtom.reportRead();
    return super.occurrenceFourEnd;
  }

  @override
  set occurrenceFourEnd(String value) {
    _$occurrenceFourEndAtom.reportWrite(value, super.occurrenceFourEnd, () {
      super.occurrenceFourEnd = value;
    });
  }

  final _$_NewEventControllerBaseActionController =
  ActionController(name: '_NewEventControllerBase');

  @override
  String setNewType() {
    final _$actionInfo = _$_NewEventControllerBaseActionController.startAction(
        name: '_NewEventControllerBase.setNewType');
    try {
      return super.setNewType();
    } finally {
      _$_NewEventControllerBaseActionController.endAction(_$actionInfo);
    }
  }

  @override
  String toString() {
    return '''
loading: ${loading},
newEvent: ${newEvent},
occurrences: ${occurrences},
occurrenceOneStart: ${occurrenceOneStart},
occurrenceOneEnd: ${occurrenceOneEnd},
occurrenceTwoStart: ${occurrenceTwoStart},
occurrenceTwoEnd: ${occurrenceTwoEnd},
occurrenceThreeStart: ${occurrenceThreeStart},
occurrenceThreeEnd: ${occurrenceThreeEnd},
occurrenceFourStart: ${occurrenceFourStart},
occurrenceFourEnd: ${occurrenceFourEnd},
isValid: ${isValid}
    ''';
  }
}
