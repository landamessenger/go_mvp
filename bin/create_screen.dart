import 'tasks/main_tasks.dart';
import 'utils/dependency.dart';
import 'utils/print.dart';

main(List<String> args) async {
  var dependencies = loadDependenciesFile();
  printDebug(introMessage(dependencies['go_mvp'].toString()));
  await MainTask().work(args);
}
