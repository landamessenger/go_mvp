import 'dart:io';

import '../../../utils/case.dart';

Future<void> createViewModelFile(String path, String name) async {
  final nominal = generateName(name);
  final content = """
import 'base_${name}_view_model.dart';

class ${nominal}ViewModel extends Base${nominal}ViewModel {
  @override
  Future<void> remoteIncrementCounter() async {
    await Future.delayed(const Duration(seconds: 5));
    state.counter++;
    callback();
  }
}

  """;
  final destinationFolder = '$path/$name/model/';
  await Directory(destinationFolder).create(recursive: true);

  final destination = '$destinationFolder/${name}_view_model.dart';
  await File(destination).writeAsString(content);
}
