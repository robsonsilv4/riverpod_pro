import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'numbers_change_notifier.dart';
import 'numbers_state_notifier.dart';

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
      home: FutureHomePage(),
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

final numberFutureProvider = FutureProvider<int>((ref) {
  return Future.value(29);
});

final numberStreamProvider = StreamProvider<int>((ref) {
  return Stream.value(29);
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

class FutureHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final futureNumber = watch(numberFutureProvider);
    final streamNumber = watch(numberStreamProvider);

    return Scaffold(
      body: Center(
        child: streamNumber.when(
          data: (data) => Text(data.toString()),
          loading: () => CircularProgressIndicator(),
          error: (error, stackTrace) => Container(),
        ),
      ),
    );
  }
}
