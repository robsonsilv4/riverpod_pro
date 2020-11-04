import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'number_state_notifier.dart';
import 'numbers_change_notifier.dart';

void main() {
  runApp(
    ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(),
    );
  }
}

final numberProvider = Provider<int>((ref) {
  return 10;
});

final numberStateProvider = StateProvider<int>((ref) {
  return 11;
});

final numbersStateNotifierProvider =
    StateNotifierProvider<NumbersNotifier>((ref) {
  return NumbersNotifier();
});

final numbersChangeNotifierProvider =
    ChangeNotifierProvider<NumbersChangeNotifier>((ref) {
  return NumbersChangeNotifier();
});

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final number = watch(numberProvider);
    final numberState = watch(numberStateProvider).state;
    final numbersStateNotifier = watch(numbersStateNotifierProvider.state);
    final numbersChangeNotifier = watch(numbersChangeNotifierProvider);

    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: numbersChangeNotifier.numbers.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(numbersChangeNotifier.numbers[index].toString());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => numbersChangeNotifier.add(1),
      ),
    );
  }
}
