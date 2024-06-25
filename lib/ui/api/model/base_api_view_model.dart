import 'package:go_mvp/go_mvp.dart';

import '../domain/api_state.dart';

abstract class BaseApiViewModel extends ViewModel<ApiState> {
  @override
  ApiState state = ApiState();

  Future<void> remoteIncrementCounter();
}

  