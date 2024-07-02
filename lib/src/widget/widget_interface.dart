import 'package:flutter/widgets.dart' hide View;
import 'package:go_router/go_router.dart';
import 'package:object/object.dart';

import '../manager/app_manager.dart';
import '../layers/presenter.dart';
import '../layers/view_model.dart';
import '../layers/view.dart';
import '../presenter_handler.dart';

abstract class WidgetInterface<
    S extends Object<S>,
    M extends ViewModel<S>,
    V extends View,
    P extends Presenter<S, M, V>,
    W extends WidgetInterface<S, M, V, P, W>> extends StatefulWidget {
  final String route;
  final String tagName;
  late final PresenterHandler<S, M, V, P> presenterHandler;

  P get presenter => presenterHandler.presenter!;

  WidgetInterface({
    super.key,
    required this.route,
    required this.tagName,
    required presenter,
  }) {
    presenterHandler = PresenterHandler(presenter);
  }

  Page<void> pageFor(
    GoRouterState state, {
    Map<String, dynamic>? extraData,
  }) =>
      AppManager().pageFor<S, M, V, P, W>(
        page: this as W,
        state: state,
        extraData: extraData,
      );
}
