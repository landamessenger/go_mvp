import 'dart:io';

import '../base/base_task.dart';

class FormatTask extends BaseTask {
  @override
  Future<void> work(List<String> args) async {
    var result = await Process.run(
      'dart',
      ['format', 'lib/'],
      workingDirectory: Directory.current.path,
    );
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  }
}
