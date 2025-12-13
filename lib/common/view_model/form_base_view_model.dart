import 'package:flutter/material.dart';
import 'package:stacked/stacked.dart';

class _FormItemModel<T> {
  T? _value;

  T? get value => _value;

  void onChange(T? value) {
    if (value != null) {
      _value = value;
    }
  }
}

mixin FormBaseViewModel on BaseViewModel {
  final Map<String, _FormItemModel> _forms = {};
  final Map<String, TextEditingController> _controller = {};
  final Map<String, KTimeFieldController> _timeController = {};

  T? getFormValue<T>(dynamic formId) =>
      _controller[formId.toString()]?.text ?? _forms[formId.toString()]?.value;

  TextEditingController getController<T>(dynamic formId) {
    _controller[formId.toString()] ??= TextEditingController();
    return _controller[formId.toString()]!;
  }

  KTimeFieldController getTimeController<T>(dynamic formId) {
    _timeController[formId.toString()] ??= KTimeFieldController();
    return _timeController[formId.toString()]!;
  }

  onFormChange<T>(dynamic formId, T value) {
    if (_forms[formId.toString()] == null) {
      _forms[formId.toString()] = _FormItemModel();
    }

    _forms[formId.toString()]!.onChange(value);
    notifyListeners();
  }
}

class KTimeFieldController {}

extension StringX2 on String? {
  bool get isNullOrEmpty => this == null || this!.isEmpty;

  bool get isNotNullAndNotEmpty => this != null && this!.trim().isNotEmpty;

  String? get filterNullOrEmpty => isNotNullAndNotEmpty ? this?.trim() : null;
}
