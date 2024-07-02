import 'package:flutter/material.dart';

import '../main_types.dart';

class MainPageState extends MainLifecycle {
  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Main Screen"),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        children: [
          const Padding(padding: EdgeInsets.all(7.5)),
          const Center(
            child: Text(
              'You have pushed the button this many times:',
            ),
          ),
          const Padding(padding: EdgeInsets.all(7.5)),
          Center(
            child: Text(
              '${state.counter}',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: presenter.sampleAction,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
