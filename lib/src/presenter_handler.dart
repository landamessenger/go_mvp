import 'package:object/object.dart';

import 'layers/presenter.dart';
import 'layers/view.dart';
import 'layers/view_model.dart';

class PresenterHandler<S extends Object<S>, M extends ViewModel<S>,
    V extends View, P extends Presenter<S, M, V>> {
  P? presenter;

  PresenterHandler(this.presenter);
}
