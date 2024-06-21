import 'package:go_mvp/go_mvp.dart';

import 'base_main_presenter.dart';

class MainPresenter extends BaseMainPresenter {
  @override
  void sampleAction() async {
    showTextSnack("Incrementing counter");
    await model.remoteIncrementCounter();
    showTextSnack("Incremented counter");
  }

  @override
  void goToNextScreen() => ['secondary'].route();
}
