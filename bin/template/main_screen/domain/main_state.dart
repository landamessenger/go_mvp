import 'dart:io';

import '../../../utils/case.dart';

Future<void> createDomainFile(String path, String name, String generatedModelPath) async {
  final nominal = generateName(name);
  final content = """
import 'package:$generatedModelPath';

class ${nominal}State extends ${nominal}StateGen {
  @override
  @Field(name: 'counter')
  int counter = 0;

  ${nominal}State();
}

  """;
  final destinationFolder = '$path/$name/domain/';
  await Directory(destinationFolder).create(recursive: true);

  final destination = '$destinationFolder/${name}_state.dart';
  await File(destination).writeAsString(content);
}