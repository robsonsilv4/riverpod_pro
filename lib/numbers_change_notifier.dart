import 'dart:collection';

import 'package:flutter/foundation.dart';

class NumbersChangeNotifier extends ChangeNotifier {
  final List<int> _numbers = [];

  UnmodifiableListView<int> get numbers => UnmodifiableListView(_numbers);

  void add(int number) {
    _numbers.add(number);
    notifyListeners();
  }
}
