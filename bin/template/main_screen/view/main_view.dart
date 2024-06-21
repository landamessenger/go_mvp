import 'dart:io';

import '../../../utils/case.dart';

Future<void> createViewFile(String path, String name) async {
  final nominal = generateName(name);
  final content = """
import 'package:go_mvp/go_mvp.dart';

abstract class ${nominal}View extends View {
  // nothing to do here
}

  """;
  final destinationFolder = '$path/$name/view/';
  await Directory(destinationFolder).create(recursive: true);

  final destination = '$destinationFolder/${name}_view.dart';
  await File(destination).writeAsString(content);
}