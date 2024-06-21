import 'package:go_mvp/go_mvp.dart';

import '../model/main_view_model.dart';
import '../view/main_view.dart';

abstract class BaseMainPresenter extends Presenter<MainView, MainViewModel> {
  @override
  MainViewModel model = MainViewModel();

  void sampleAction();
}
