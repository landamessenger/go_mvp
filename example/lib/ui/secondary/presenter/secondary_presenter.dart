import 'base_secondary_presenter.dart';

class SecondaryPresenter extends BaseSecondaryPresenter {
  @override
  void sampleAction() async {
    showTextSnack("Incrementing counter");
    await model.remoteIncrementCounter();
    showTextSnack("Incremented counter");
  }
}
