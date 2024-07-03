import 'package:go_router/go_router.dart';

import '../manager/app_manager.dart';
import '../utils/print.dart';

const String _slash = '/';

extension NavigatorExt on List<String> {
  /// If [AppManager().slashResolution] is defined, it will be used when / is
  /// received.
  void route({
    Map<String, dynamic> query = const {},
  }) {
    final manager = AppManager();

    removeWhere((str) => str.isEmpty);

    final clean = map((i) => i.replaceAll(_slash, '')).toList();

    var path = '$_slash${clean.join(_slash)}';

    if (manager.slashResolution.isNotEmpty && path == _slash) {
      path = '$_slash${manager.slashResolution.replaceAll(_slash, '')}';
    }

    if (manager.debug) {
      printDebug('Routing to path: $path');
    }

    manager.lastExtra.addAll(query);
    manager.context.go(path);
  }
}
