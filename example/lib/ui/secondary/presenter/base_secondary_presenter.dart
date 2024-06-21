import '../secondary_types.dart';
import '../model/secondary_view_model.dart';

abstract class BaseSecondaryPresenter extends SecondaryPresenterDefinition {
  @override
  SecondaryViewModel model = SecondaryViewModel();

  void sampleAction();
}
