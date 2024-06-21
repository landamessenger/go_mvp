import 'dart:io';

import '../../utils/case.dart';

Future<void> createPageFile(String path, String name) async {
  final nominal = generateName(name);
  final content = """
import 'package:flutter/material.dart';
import 'package:go_mvp/go_mvp.dart';

import 'presenter/${name}_presenter.dart';
import 'view/${name}_page_state.dart';

class ${nominal}Page extends WidgetInterface<${nominal}Presenter, ${nominal}Page> {
  static const String routeName = '$name';
  static const String tagStateName = '_${nominal}PageState';

  ${nominal}Page({
    Key? key,
  }) : super(
          presenter: ${nominal}Presenter(),
          key: const ValueKey(tagStateName),
          route: routeName,
          tagName: tagStateName,
        );

  @override
  ${nominal}PageState createState() => ${nominal}PageState();
}

  """;
  final destinationFolder = '$path/$name/';
  await Directory(destinationFolder).create(recursive: true);

  final destination = '$destinationFolder/${name}_page.dart';
  await File(destination).writeAsString(content);
}
