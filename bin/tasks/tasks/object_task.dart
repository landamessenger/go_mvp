import 'dart:io';

import '../base/base_task.dart';

class ObjectTask extends BaseTask {
  @override
  Future<void> work(List<String> args) async {
    var result = await Process.run(
      'dart',
      ['run', 'object:build'],
      workingDirectory: Directory.current.path,
    );
    stdout.write(result.stdout);
    stderr.write(result.stderr);
  }
}
