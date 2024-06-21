import 'dart:io';

import '../../utils/case.dart';

Future<void> createTypesFile(String path, String name) async {
    final nominal = generateName(name);
    final content = """
import 'package:go_mvp/go_mvp.dart';

import 'domain/${name}_state.dart';
import '${name}_page.dart';
import 'model/${name}_view_model.dart';
import 'presenter/${name}_presenter.dart';
import 'view/${name}_view.dart';

/// This file has been generated automatically.
/// We do not recommend you to edit it.
///
/// It contains the type definitions of the MVP architecture layer relationship. 

typedef ${nominal}Widget = WidgetInterface<${nominal}State, ${nominal}ViewModel, ${nominal}View,
    ${nominal}Presenter, ${nominal}Page>;

typedef ${nominal}LifecycleDefinition
    = Lifecycle<${nominal}State, ${nominal}ViewModel, ${nominal}View, ${nominal}Presenter, ${nominal}Page>;

typedef ${nominal}PresenterDefinition = Presenter<${nominal}State, ${nominal}ViewModel, ${nominal}View>;

abstract class ${nominal}Lifecycle extends ${nominal}LifecycleDefinition
    implements ${nominal}View {}

  """;
    final destinationFolder = '$path/$name/';
    await Directory(destinationFolder).create(recursive: true);

    final destination = '$destinationFolder/${name}_types.dart';
    await File(destination).writeAsString(content);
}

