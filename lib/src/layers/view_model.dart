import 'package:object/object.dart';

import '../manager/page_manager.dart';

// <S extends Object<S>>
abstract class ViewModel {
  //abstract S state;

  final pageManager = PageManager();

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
