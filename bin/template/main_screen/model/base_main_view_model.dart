import 'dart:io';

import '../../../utils/case.dart';

Future<void> createBaseViewModelFile(String path, String name) async {
  final nominal = generateName(name);
  final content = """
import 'package:go_mvp/go_mvp.dart';

import '../domain/${name}_state.dart';

abstract class Base${nominal}ViewModel extends ViewModel<${nominal}State> {
  @override
  ${nominal}State state = ${nominal}State();

  Future<void> remoteIncrementCounter();
}

  """;
  final destinationFolder = '$path/$name/model/';
  await Directory(destinationFolder).create(recursive: true);

  final destination = '$destinationFolder/base_${name}_view_model.dart';
  await File(destination).writeAsString(content);
}