import 'package:go_mvp/go_mvp.dart';

import '../model/secondary_view_model.dart';
import '../view/secondary_view.dart';
import '../domain/secondary_state.dart';

abstract class BaseSecondaryPresenter
    extends Presenter<SecondaryView, SecondaryViewModel> {
  SecondaryState get state => model.state;

  @override
  SecondaryViewModel model = SecondaryViewModel();

  void sampleAction();
}
