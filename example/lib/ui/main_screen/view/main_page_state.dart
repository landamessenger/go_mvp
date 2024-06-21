import 'package:flutter/material.dart';
import 'package:go_mvp/go_mvp.dart';

import '../main_page.dart';
import '../presenter/main_presenter.dart';
import 'main_view.dart';

class MainPageState extends Lifecycle<MainPage, MainPageState, MainPresenter>
    implements MainView {
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
              '${presenter.state.counter}',
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
