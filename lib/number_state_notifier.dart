import 'package:flutter_riverpod/flutter_riverpod.dart';

class NumbersNotifier extends StateNotifier<List<int>> {
  NumbersNotifier() : super([]);

  void add(int number) {
    state = [...state, number];
  }

  void delete(int number) {
    state = [
      for (final loopNumber in state)
        if (number != loopNumber) loopNumber,
    ];
  }
}
