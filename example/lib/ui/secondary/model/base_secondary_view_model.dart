import 'package:go_mvp/go_mvp.dart';

import '../domain/secondary_state.dart';

abstract class BaseSecondaryViewModel extends ViewModel<SecondaryState> {
  @override
  SecondaryState state = SecondaryState();

  Future<void> remoteIncrementCounter();
}
