import 'package:flutter/cupertino.dart';

class MultiValueObserver<T> extends ValueNotifier<T?> {
  MultiValueObserver(this.observers) : super(null) {
    for (var element in observers) {
      element.addListener(() => notifyListeners());
    }
  }
  final List<ValueNotifier<T>> observers;
  final List<T> staticValue = [];

  void add(ValueNotifier<T> item) {
    item.addListener(() => notifyListeners());
    observers.add(item);
  }

  void remove(ValueNotifier<T> item) {
    observers.remove(item);
  }

  List<T> get values => observers.map((e) => e.value).toList();
}
