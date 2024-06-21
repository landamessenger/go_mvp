import 'package:flutter/widgets.dart';

import 'layers/presenter.dart';

abstract class StateInterface {
  BuildContext? get safeContext;

  Presenter get presenter;

  BuildContext get context;

  bool get mounted;

  Future<void> onCreate();

  Future<void> onResume();

  Future<void> onPause();

  Future<void> onDestroy();
}
