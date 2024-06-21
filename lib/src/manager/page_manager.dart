import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide View;
import 'package:object/object.dart';
import 'package:go_router/go_router.dart';

import '../layers/presenter.dart';
import '../layers/view_model.dart';
import '../layers/view.dart';
import '../utils/json_ext.dart';
import '../widget_interface.dart';

class PageManager {
  final Map<String, Presenter> _presenterMap = {};
  static PageManager? _instance;

  final Map<String, dynamic> lastExtra = {};

  GoRouter? router;

  final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

  BuildContext get context {
    final context = router?.routerDelegate.navigatorKey.currentContext ??
        navigatorKey.currentContext;
    if (context == null) {
      throw Exception('💥 Context not ready');
    }
    return context;
  }

  Future Function(String) screenVisible = (_) async {};

  bool lowPerformance = false;
  int refreshLatency = 500;

  final global = GlobalKey();
  final key = GlobalKey<ScaffoldMessengerState>();

  PageManager._internal();

  factory PageManager() {
    _instance ??= PageManager._internal();
    return _instance!;
  }

  Page<void> pageFor<
      S extends Object<S>,
      M extends ViewModel<S>,
      V extends View,
      P extends Presenter<S, M, V>,
      W extends WidgetInterface<S, M, V, P, W>>({
    required W page,
    required GoRouterState state,
    Map<String, dynamic>? extraData,
  }) {
    final extra = extraData ?? {};
    final data = getDataForState(state);
    final query = state.uri.queryParameters;
    if (data['query'] != null) {
      data.remove('query');
    }

    var key =
        '${page.presenterHandler.presenter.runtimeType}__${data.toPrettyString()}';

    P? presenter;
    if (!_presenterMap.containsKey(key)) {
      if (kDebugMode) {
        print('*** Caching presenter: $key');
      }
      _presenterMap[key] = page.presenter;
      presenter = page.presenter;

      if (lastExtra.isNotEmpty) {
        for (var k in lastExtra.keys) {
          presenter.withExtras(k, lastExtra[k]);
        }
        lastExtra.clear();
      }
    } else {
      if (kDebugMode) {
        print('*** Returning cached presenter: $key');
      }
      presenter = _presenterMap[key] as P;
    }

    extra.addAll(data);
    extra.addAll(query);

    if (!presenter.initialized) {
      presenter.initialized = true;
      presenter.withData(extra);
    } else {
      presenter.refreshScreen();
    }

    presenter.key = key;
    presenter.traceId = '${page.presenterHandler.presenter.runtimeType}';

    page.presenterHandler.presenter = presenter;

    if (kIsWeb) {
      return NoTransitionPage(
        key: state.pageKey,
        child: page,
      );
    } else if (presenter.requiresHero()) {
      return MaterialPage(
        key: state.pageKey,
        child: page,
      );
    }
    return NoTransitionPage(
      key: state.pageKey,
      child: page,
    );
  }

  Map<String, String> getDataForState(GoRouterState state) {
    const dataPrefix = ':';
    final data = state.pathParameters;
    final currentPath = state.path?.replaceAll('/', '') ?? '';
    List<String> parts = state.fullPath?.split('/') ?? [currentPath];

    if (parts.first == '') {
      parts.removeAt(0);
    }

    final keys = <String>[];
    for (String path in parts) {
      if (path == currentPath) {
        if (path.startsWith(dataPrefix)) {
          keys.add(path.replaceAll(dataPrefix, ''));
        }
        break;
      }
      if (path.startsWith(dataPrefix)) {
        keys.add(path.replaceAll(dataPrefix, ''));
      }
    }

    final validData = <String, String>{};
    for (final key in keys) {
      final value = data[key];
      if (value == null) continue;
      validData[key] = value;
    }
    return validData;
  }

  void clear() {
    _presenterMap.clear();
  }

  void clearCacheOf(String key) {
    if (_presenterMap.containsKey(key)) {
      _presenterMap.remove(key);
    }
  }

  String _popKey = '';

  String get popKey {
    final k = _popKey;
    _popKey = '';
    return k;
  }

  dynamic _popValue;

  dynamic get popValue {
    final p = _popValue;
    _popValue = null;
    return p;
  }

  void onPop(String key, dynamic value) {
    _popKey = key;
    _popValue = value;
  }
}
