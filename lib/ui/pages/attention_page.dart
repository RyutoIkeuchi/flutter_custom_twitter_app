import 'package:flutter/material.dart';
import 'package:flutter_custom_twitter_app/ViewModel/countProvider.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class Attention extends ConsumerWidget {
  @override
  Widget build(BuildContext context, ScopedReader watch) {
     final count = watch(counterProvider);
    return MaterialApp(
        title: 'Attention',
        home: Scaffold(
          appBar: AppBar(title: Text('通知')),
          body: Center(
            child: Text(count.toString()),
          ),
          floatingActionButton: FloatingActionButton(
            onPressed: () {
              context.read(counterProvider.notifier).increment();
            },
            child: Icon(Icons.add),
          ),
        ));
  }
}
