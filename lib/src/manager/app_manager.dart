import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide View;
import 'package:go_router/go_router.dart';
import 'package:object/object.dart';

import '../layers/presenter.dart';
import '../layers/view.dart';
import '../layers/view_model.dart';
import '../utils/json_ext.dart';
import '../widget/widget_interface.dart';

class AppManager {
  final Map<String, Presenter> _presenterMap = {};
  static AppManager? _instance;

  /// Debug mode
  bool _debug = false;

  bool get debug => _debug;

  /// Slash resolution
  String _slashResolution = '';

  String get slashResolution => _slashResolution;

  /// Router
  GoRouter? _router;

  GoRouter? get router => _router;

  /// Low performance mode
  bool _lowPerformance = false;

  bool get lowPerformance => _lowPerformance;

  /// Refresh latency
  int _refreshLatency = 500;

  int get refreshLatency => _refreshLatency;

  /// Screen visible callback
  Future Function(String) _screenVisible = (_) async {};

  Future Function(String) get screenVisible => _screenVisible;

  final Map<String, dynamic> lastExtra = {};

  BuildContext get context {
    final context = router?.routerDelegate.navigatorKey.currentContext ??
        navigatorKey.currentContext;
    if (context == null) {
      throw Exception('💥 Context not ready');
    }
    return context;
  }

  final global = GlobalKey();

  final navigatorKey = GlobalKey<NavigatorState>();

  final scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  AppManager._internal();

  factory AppManager() {
    _instance ??= AppManager._internal();
    return _instance!;
  }

  void configure({
    required GoRouter router,
    required ObjectModel object,
    String slashResolution = '',
    bool debug = false,
    bool lowPerformance = false,
    int refreshLatency = 500,
    List<dynamic> additionalClasses = const [],
    Future Function(String)? screenVisible,
  }) {
    _slashResolution = slashResolution;
    _debug = debug;
    _lowPerformance = lowPerformance;
    _refreshLatency = refreshLatency;
    _router = router;
    _screenVisible = screenVisible ?? (_) async {};
    object.instancesForLoad(additional: additionalClasses);
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
