import 'package:go_mvp/go_mvp.dart';

import 'domain/main_state.dart';
import 'main_page.dart';
import 'model/main_view_model.dart';
import 'presenter/main_presenter.dart';
import 'view/main_view.dart';

/// This file has been generated automatically.
/// We do not recommend you to edit it.
///
/// It contains the type definitions of the MVP architecture layer relationship.

typedef MainWidget = WidgetInterface<MainState, MainViewModel, MainView,
    MainPresenter, MainPage>;

typedef MainLifecycleDefinition
    = Lifecycle<MainState, MainViewModel, MainView, MainPresenter, MainPage>;

typedef MainPresenterDefinition = Presenter<MainState, MainViewModel, MainView>;

abstract class MainLifecycle extends MainLifecycleDefinition
    implements MainView {}
