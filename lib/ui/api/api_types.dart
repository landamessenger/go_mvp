import 'package:go_mvp/go_mvp.dart';

import 'domain/api_state.dart';
import 'api_page.dart';
import 'model/api_view_model.dart';
import 'presenter/api_presenter.dart';
import 'view/api_view.dart';

/// This file has been generated automatically.
/// We do not recommend you to edit it.
///
/// It contains the type definitions of the MVP architecture layer relationship. 

typedef ApiWidget = WidgetInterface<ApiState, ApiViewModel, ApiView,
    ApiPresenter, ApiPage>;

typedef ApiLifecycleDefinition
    = Lifecycle<ApiState, ApiViewModel, ApiView, ApiPresenter, ApiPage>;

typedef ApiPresenterDefinition = Presenter<ApiState, ApiViewModel, ApiView>;

abstract class ApiLifecycle extends ApiLifecycleDefinition
    implements ApiView {}

  