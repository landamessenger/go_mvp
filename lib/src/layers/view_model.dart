import 'package:object/object.dart';

import '../manager/app_manager.dart';

abstract class ViewModel<S extends Object<S>> {
  abstract S state;

  final appManager = AppManager();

  Function() callback = () {};

  Future<void> onCreate() async {
    // nothing to do here
  }

  Future<void> onResume() async {
    // nothing to do here
  }

  Future<void> onPause() async {
    // nothing to do here
  }

  Future<void> onDestroy() async {
    // nothing to do here
  }

  void exception(Exception e) {
    // do something with the exception
  }
}
