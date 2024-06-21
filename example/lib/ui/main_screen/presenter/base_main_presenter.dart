import '../main_types.dart';
import '../model/main_view_model.dart';

abstract class BaseMainPresenter extends MainPresenterDefinition {
  @override
  MainViewModel model = MainViewModel();

  void sampleAction();

  void goToNextScreen();
}
