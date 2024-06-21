import 'package:go_mvp/go_mvp.dart';

import 'domain/secondary_state.dart';
import 'secondary_page.dart';
import 'model/secondary_view_model.dart';
import 'presenter/secondary_presenter.dart';
import 'view/secondary_view.dart';

/// This file has been generated automatically.
/// We do not recommend you to edit it.
///
/// It contains the type definitions of the MVP architecture layer relationship.

typedef SecondaryWidget = WidgetInterface<SecondaryState, SecondaryViewModel,
    SecondaryView, SecondaryPresenter, SecondaryPage>;

typedef SecondaryLifecycleDefinition = Lifecycle<SecondaryState,
    SecondaryViewModel, SecondaryView, SecondaryPresenter, SecondaryPage>;

typedef SecondaryPresenterDefinition
    = Presenter<SecondaryState, SecondaryViewModel, SecondaryView>;

abstract class SecondaryLifecycle extends SecondaryLifecycleDefinition
    implements SecondaryView {}
