import 'dart:io';

import '../base/base_task.dart';
import '../../template/main_screen/domain/main_state.dart';
import '../../template/main_screen/main_page.dart';
import '../../template/main_screen/main_types.dart';
import '../../template/main_screen/model/base_main_view_model.dart';
import '../../template/main_screen/model/main_view_model.dart';
import '../../template/main_screen/presenter/base_main_presenter.dart';
import '../../template/main_screen/presenter/main_presenter.dart';
import '../../template/main_screen/view/main_page_state.dart';
import '../../template/main_screen/view/main_view.dart';
import '../../utils/case.dart';
import '../../utils/dependency.dart';
import '../../utils/print.dart';

const baseProject = 'lib';

class GenerateScreenTask extends BaseTask {
  @override
  Future<void> work(List<String> args) async {

    var appId = loadId();
    var config = loadConfigFile();

    final baseProjectFolder = config['baseProjectFolder'] ?? baseProject;
    final dir = Directory('./$baseProjectFolder');
    await dir.create(recursive: true);

    final outputFolder = baseProjectFolder + '/' + (config['outputFolder'] ?? '');

    final outputFolderDir = Directory('./$outputFolder');
    await outputFolderDir.create(recursive: true);

    final String modelsFile = config['modelsFile'] ?? 'model.g.dart';

    final destinationPath = outputFolder;
    final newPathName = args[0];
    final generatedModelPath = '$appId/$modelsFile';

    final composedDestinationPath = '$destinationPath/$newPathName/';

    printDebug(
        '🟢 Generating new screen ${generateName(newPathName)} on $composedDestinationPath');

    final folder = Directory(composedDestinationPath);
    if (await folder.exists()) {
      printDebug('🔴 Destination folder $composedDestinationPath already exists');
    }

    await createDomainFile(destinationPath, newPathName, generatedModelPath);
    await createBaseViewModelFile(destinationPath, newPathName);
    await createViewModelFile(destinationPath, newPathName);
    await createBasePresenterFile(destinationPath, newPathName);
    await createPresenterFile(destinationPath, newPathName);
    await createPageStateFile(destinationPath, newPathName);
    await createViewFile(destinationPath, newPathName);
    await createPageFile(destinationPath, newPathName);
    await createTypesFile(destinationPath, newPathName);

  }
}
