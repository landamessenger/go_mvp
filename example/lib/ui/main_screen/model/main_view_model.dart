import 'base_main_view_model.dart';

class MainViewModel extends BaseMainViewModel {
  @override
  Future<void> remoteIncrementCounter() async {
    await Future.delayed(const Duration(seconds: 5));
    state.counter++;
    callback();
  }
}
