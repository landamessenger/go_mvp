import 'package:go_mvp/go_mvp.dart';

import '../../secondary/secondary_page.dart';
import 'base_main_presenter.dart';

class MainPresenter extends BaseMainPresenter {
  @override
  void sampleAction() async {
    showTextSnack("Incrementing counter. It was ${state.counter}");
    await model.remoteIncrementCounter();
    showTextSnack("Incremented counter");
  }

  @override
  void goToNextScreen() => [SecondaryPage.routeName].route();

}
