import 'dart:io';

import '../../../utils/case.dart';

Future<void> createBasePresenterFile(String path, String name) async {
  final nominal = generateName(name);
  final content = """
import 'package:go_mvp/go_mvp.dart';

import '../model/${name}_view_model.dart';
import '../view/${name}_view.dart';
import '../domain/${name}_state.dart';

abstract class Base${nominal}Presenter extends Presenter<${nominal}View, ${nominal}ViewModel> {
  ${nominal}State get state => model.state;

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
