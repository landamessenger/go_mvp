import 'package:example/ui/main_screen/domain/main_state.dart';

import 'base_main_presenter.dart';

class MainPresenter extends BaseMainPresenter {
  MainState get state => model.state;

  @override
  void sampleAction() async {
    showTextSnack("Incrementing counter");
    await model.remoteIncrementCounter();
    showTextSnack("Incremented counter");
  }
}
