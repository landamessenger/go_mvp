import 'base_api_view_model.dart';

class ApiViewModel extends BaseApiViewModel {
  @override
  Future<void> remoteIncrementCounter() async {
    await Future.delayed(const Duration(seconds: 5));
    state.counter++;
    callback();
  }
}

  