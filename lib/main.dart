import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_pro/number_state_notifier.dart';

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

class MyHomePage extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final number = watch(numberProvider);
    final numberState = watch(numberStateProvider).state;
    final numbersStateNotifier = watch(numbersStateNotifierProvider.state);

    void increment(BuildContext context) {
      context.read(numberStateProvider).state++;
    }

    return Scaffold(
      body: Center(
        child: ListView.builder(
          itemCount: numbersStateNotifier.length,
          itemBuilder: (BuildContext context, int index) {
            return Text(numbersStateNotifier[index].toString());
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => context.read(numbersStateNotifierProvider).add(1),
      ),
    );
  }
}
