import '../api_types.dart';
import '../model/api_view_model.dart';

abstract class BaseApiPresenter extends ApiPresenterDefinition {
  @override
  ApiViewModel model = ApiViewModel();

  void sampleAction();
}

  