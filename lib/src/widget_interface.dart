import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';

import 'manager/page_manager.dart';
import 'layers/presenter.dart';
import 'presenter_handler.dart';

abstract class WidgetInterface<P extends Presenter,
    V extends WidgetInterface<P, V>> extends StatefulWidget {
  final String route;
  final String tagName;
  late final PresenterHandler<P> presenterHandler;

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
      PageManager().pageFor(
        page: this,
        state: state,
        extraData: extraData,
      );
}
