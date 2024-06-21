import 'layers/presenter.dart';

class PresenterHandler<P extends Presenter> {
  P? presenter;

  PresenterHandler(this.presenter);
}
