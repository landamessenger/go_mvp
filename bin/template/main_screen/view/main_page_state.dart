import 'dart:io';

import '../../../utils/case.dart';

Future<void> createPageStateFile(String path, String name) async {
  final nominal = generateName(name);
  final content = """
import 'package:flutter/material.dart';
import 'package:go_mvp/go_mvp.dart';

import '../${name}_page.dart';
import '../presenter/${name}_presenter.dart';
import '${name}_view.dart';

class ${nominal}PageState extends Lifecycle<${nominal}Page, ${nominal}PageState, ${nominal}Presenter>
    implements ${nominal}View {
  @override
  Widget onBuild(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("$nominal Screen"),
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
              '\${presenter.state.counter}',
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


  """;
  final destinationFolder = '$path/$name/view/';
  await Directory(destinationFolder).create(recursive: true);

  final destination = '$destinationFolder/${name}_page_state.dart';
  await File(destination).writeAsString(content);
}