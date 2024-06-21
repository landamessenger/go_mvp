import 'package:go_mvp/go_mvp.dart';

import '../domain/main_state.dart';

abstract class BaseMainViewModel extends ViewModel {
  //@override
  MainState state = MainState();

  Future<void> remoteIncrementCounter();
}
