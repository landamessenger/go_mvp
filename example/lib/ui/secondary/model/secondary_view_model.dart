import 'base_secondary_view_model.dart';

class SecondaryViewModel extends BaseSecondaryViewModel {
  @override
  Future<void> remoteIncrementCounter() async {
    await Future.delayed(const Duration(seconds: 5));
    state.counter++;
    callback();
  }
}
