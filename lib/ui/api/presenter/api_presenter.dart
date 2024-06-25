import 'base_api_presenter.dart';

class ApiPresenter extends BaseApiPresenter {
  @override
  void sampleAction() async {
    showTextSnack("Incrementing counter");
    await model.remoteIncrementCounter();
    showTextSnack("Incremented counter");
  }
}

  