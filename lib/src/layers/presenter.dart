import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart' hide View;
import 'package:flutter/services.dart';
import 'package:object/object.dart';

import '../manager/app_manager.dart';
import 'view.dart';
import 'view_model.dart';

abstract class Presenter<S extends Object<S>, M extends ViewModel<S>,
    V extends View> {
  S get state => model.state;

  bool initialized = false;

  String key = '';
  String traceId = '';

  bool created = false;
  bool destroyed = false;

  AppManager get appManager => model.appManager;

  BuildContext get context => view.context;

  BuildContext? get safeContext => view.safeContext;

  bool loading = true;

  V? _view;

  V get view => _view!;

  void setView(V view) {
    _view = view;
  }

  abstract M model;

  Presenter() {
    loading = true;
    model.callback = refreshScreen;
  }

  Future<bool> onCreate() async {
    if (created) {
      return false;
    }
    created = true;
    await model.onCreate();
    return true;
  }

  Future<bool> onResume() async {
    await model.onResume();
    refreshScreen();
    return true;
  }

  void exception(Exception e) {
    model.exception(e);
  }

  Future<void> onPause() async {
    await model.onPause();
  }

  Future<bool> onDestroy() async {
    if (destroyed) {
      return false;
    }
    destroyed = true;

    await model.onDestroy();

    appManager.clearCacheOf(key);

    return true;
  }

  bool screenReady() {
    if (_view == null) return false;
    return view.mounted;
  }

  void withData(dynamic data) {
    // nothing to do here
  }

  void seoRender() {
    // nothing to do here
  }

  void refreshScreen() {
    if (screenReady()) {
      view.refresh(this);
    }
  }

  bool requiresHero() => true;

  void exit() {
    if (safeContext == null) return;
    Navigator.of(safeContext!).pop();
  }

  void exitWith(String key, dynamic data) {
    if (safeContext == null) return;
    AppManager().onPop(key, data);
    Navigator.of(safeContext!).pop();
  }

  void showSnack(Widget widget) {
    appManager.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: widget,
      ),
    );
  }

  void showTextSnack(String text) {
    appManager.scaffoldMessengerKey.currentState?.showSnackBar(
      SnackBar(
        content: Text(
          text,
          style: const TextStyle(
            letterSpacing: .2,
            height: 1.5,
          ),
        ),
      ),
    );
  }

  void withExtras(String key, dynamic value) {
    // nothing to do here
  }

  void onResult(String key, dynamic value) {
    // nothing to do here
  }

  void exportState<T>(Object<T> state) async {
    if (!kDebugMode) {
      return;
    }

    Clipboard.setData(ClipboardData(text: state.toReadableJson()));
  }
}
