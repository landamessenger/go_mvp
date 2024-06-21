import 'dart:io';

import '../../../utils/case.dart';

Future<void> createPresenterFile(String path, String name) async {
  final nominal = generateName(name);
  final content = """
import 'base_${name}_presenter.dart';

class ${nominal}Presenter extends Base${nominal}Presenter {
  @override
  void sampleAction() async {
    showTextSnack("Incrementing counter");
    await model.remoteIncrementCounter();
    showTextSnack("Incremented counter");
  }
}

  """;
  final destinationFolder = '$path/$name/presenter/';
  await Directory(destinationFolder).create(recursive: true);

  final destination = '$destinationFolder/${name}_presenter.dart';
  await File(destination).writeAsString(content);
}

