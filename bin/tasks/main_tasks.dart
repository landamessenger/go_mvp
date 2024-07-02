import '../utils/print.dart';
import 'base/base_task.dart';
import 'tasks/format_task.dart';
import 'tasks/generate_screen_task.dart';
import 'tasks/object_task.dart';

class MainTask extends BaseTask {
  final tasks = [
    GenerateScreenTask(),
    FormatTask(),
    ObjectTask(),
  ];

  @override
  Future<void> work(List<String> args) async {
    for (BaseTask task in tasks) {
      try {
        printDebug('\n - Running ${task.runtimeType.toString()} \n');
        await task.work(args);
      } catch (e) {
        printDebug(e);
      }
    }
    printDebug('\n Object models generated \n');
  }
}
