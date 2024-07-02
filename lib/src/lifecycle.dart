import 'package:object/object.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide View;
import 'package:go_mvp/src/manager/app_manager.dart';
import 'package:visibility_detector/visibility_detector.dart';

import 'layers/presenter.dart';
import 'layers/view.dart';
import 'layers/view_model.dart';
import 'utils/print.dart';
import 'widget/widget_interface.dart';

// Register the RouteObserver as a navigation observer.
final RouteObserver<ModalRoute> routeObserver = RouteObserver<ModalRoute>();

enum Status { initial, created, resumed, paused, destroyed }

abstract class Lifecycle<
        S extends Object<S>,
        M extends ViewModel<S>,
        V extends View,
        P extends Presenter<S, M, V>,
        W extends WidgetInterface<S, M, V, P, W>> extends State
    with WidgetsBindingObserver, RouteAware {
  String tagInStateWithLifecycle = 'StateWithLifecycle';

  @override
  W get widget => super.widget as W;

  V get view => this as V;

  late P presenter;

  S get state => presenter.state;

  BuildContext? get safeContext {
    if (mounted) {
      return context;
    }
    return null;
  }

  Function()? _callback;

  Status status = Status.initial;

  bool pop = false;
  bool disposed = false;

  void refresh(Presenter presenter) {
    if (AppManager().lowPerformance == true) {
      if (_callback == null) {
        _callback = () {
          printDebug('🐢 Low latency refresh');

          setState(() {
            this.presenter = presenter as P;
          });
        };
        Future.delayed(
          Duration(
            milliseconds: AppManager().refreshLatency,
          ),
          () {
            if (_callback != null) {
              _callback!();
              _callback = null;
            }
          },
        );
      }
    } else {
      printDebug('🚄 High latency refresh');

      setState(() {
        this.presenter = presenter as P;
      });
    }
  }

  @override
  void initState() {
    presenter = widget.presenter;
    tagInStateWithLifecycle = widget.tagName;
    super.initState();
    // printDebug('$tagInStateWithLifecycle --> initState');

    onCreate().then((e) {
      onResume().then((e) {
        WidgetsBinding.instance.addObserver(this);
      });
    });
  }

  Widget onBuild(BuildContext context);

  @override
  Widget build(BuildContext context) {
    widget.presenter.setView(view);

    if (kIsWeb) {
      return VisibilityDetector(
        key: ValueKey(widget.presenter.traceId),
        onVisibilityChanged: (VisibilityInfo info) {
          try {
            if (info.visibleFraction > .2 && widget.presenter.screenReady()) {
              widget.presenter.seoRender();
            }
          } catch (e) {
            printDebug(e);
          }
        },
        child: onBuild(context),
      );
    }

    return onBuild(context);
  }

  @override
  void setState(fn) {
    if (mounted && !disposed) {
      super.setState(fn);
    }
  }

  @override
  void dispose() {
    // printDebug('$tagInStateWithLifecycle --> dispose');
    super.dispose();
    WidgetsBinding.instance.removeObserver(this);
    routeObserver.unsubscribe(this);
    onDestroy().then((value) => null);
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) async {
    switch (state) {
      case AppLifecycleState.resumed:
        // printDebug('$tagInStateWithLifecycle --> AppLifecycleState.resumed');
        await onResume();
        break;
      case AppLifecycleState.inactive:
        // printDebug('$tagInStateWithLifecycle --> AppLifecycleState.inactive');
        await onPause();
        break;
      case AppLifecycleState.paused:
        // printDebug('$tagInStateWithLifecycle --> AppLifecycleState.paused');
        await onPause();
        break;
      case AppLifecycleState.detached:
        break;
      default:
        break;
    }
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    routeObserver.subscribe(this, ModalRoute.of(context)!);
  }

  /// Called when a new route has been pushed,
  /// and the current route is no longer visible.
  @override
  void didPushNext() async {
    // printDebug('$tagInStateWithLifecycle:didPushNext');
    super.didPushNext();
    pop = true;
    await onPause();
  }

  /// Called when the top route has been popped off,
  /// and the current route shows up.
  @override
  void didPopNext() async {
    // printDebug('$tagInStateWithLifecycle:didPopNext');
    super.didPopNext();
    pop = false;
    final pageManager = AppManager();
    final popKey = pageManager.popKey;
    final popValue = pageManager.popValue;
    if (popKey.isNotEmpty && popValue != null) {
      presenter.onResult(popKey, popValue);
    }
    await onResume();
  }

  /// Called when the current route has been popped off.
  @override
  void didPop() async {
    // printDebug('$tagInStateWithLifecycle:didPop');
    super.didPop();
    await onPause();
  }

  Future<void> onCreate() async {
    if (status == Status.created) {
      return;
    }
    status = Status.created;
    widget.presenter.setView(view);
    printDebug('$tagInStateWithLifecycle --> onCreate()');

    await widget.presenter.onCreate();
  }

  Future<void> onResume() async {
    if (pop) {
      return;
    }
    if (status == Status.resumed) {
      return;
    }
    status = Status.resumed;
    printDebug('$tagInStateWithLifecycle --> onResume()');

    await AppManager().screenVisible(tagInStateWithLifecycle);

    widget.presenter.setView(view);
    await widget.presenter.onResume();
  }

  Future<void> onPause() async {
    if (status == Status.paused) {
      return;
    }
    status = Status.paused;
    printDebug('$tagInStateWithLifecycle --> onPause()');

    await widget.presenter.onPause();
  }

  Future<void> onDestroy() async {
    if (status == Status.destroyed) {
      return;
    }
    status = Status.destroyed;
    disposed = true;
    printDebug('$tagInStateWithLifecycle --> onDestroy()');

    if (!widget.presenter.destroyed) await widget.presenter.onDestroy();
  }

  List<Widget> actions() {
    return [];
  }
}
