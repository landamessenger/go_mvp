import 'dart:io';

import 'utils/print.dart';
import 'utils/case.dart';
import 'template/main_screen/domain/main_state.dart';
import 'template/main_screen/model/base_main_view_model.dart';
import 'template/main_screen/model/main_view_model.dart';
import 'template/main_screen/presenter/base_main_presenter.dart';
import 'template/main_screen/presenter/main_presenter.dart';
import 'template/main_screen/view/main_page_state.dart';
import 'template/main_screen/view/main_view.dart';
import 'template/main_screen/main_page.dart';

main(List<String> args) async {
  if (args.length != 3) {
    printDebug('\n⭕\t Not valid arguments. Only three allowed.\n\n');
    printDebug('1º path of the screen destination; ex. lib/ui');
    printDebug(
        '2º name of the new screen; ex. secondary_screen (SecondaryScreen)');
    printDebug(
        '3º path for generated state model; ex. example/data/model/generated/model.g.dart');
    printDebug(
        '\nSample: \n\n dart run go_mvp:create_screen lib/ui other_screen lib/data/model/generated/model.g.dart \n');
    return;
  }

  final destinationPath = args.first;
  final newPathName = args[1];
  final generatedModelPath = args[2];

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
  await createPresenterFile(destinationPath, newPathName, generatedModelPath);
  await createPageStateFile(destinationPath, newPathName);
  await createViewFile(destinationPath, newPathName);
  await createPageFile(destinationPath, newPathName);
}

