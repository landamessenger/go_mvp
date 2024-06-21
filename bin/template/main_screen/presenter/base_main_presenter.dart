import 'dart:io';

import '../../../utils/case.dart';

Future<void> createBasePresenterFile(String path, String name) async {
  final nominal = generateName(name);
  final content = """
import '../${name}_types.dart';
import '../model/${name}_view_model.dart';

abstract class Base${nominal}Presenter extends ${nominal}PresenterDefinition {
  @override
  ${nominal}ViewModel model = ${nominal}ViewModel();

  void sampleAction();
}

  """;
  final destinationFolder = '$path/$name/presenter/';
  await Directory(destinationFolder).create(recursive: true);

  final destination = '$destinationFolder/base_${name}_presenter.dart';
  await File(destination).writeAsString(content);
}
