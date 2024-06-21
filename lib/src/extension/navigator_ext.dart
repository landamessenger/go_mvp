import 'package:go_router/go_router.dart';

import '../manager/page_manager.dart';
import '../utils/print.dart';

extension NavigatorExt on List<String> {
  void route({
    Map<String, dynamic>? query,
  }) {
    String slash = '/';
    if (this[0] == '') {
      removeAt(0);
    }

    final clean = <String>[];
    for (var i in this) {
      var a = i.replaceAll('/', '');
      clean.add(a);
    }
    var path = '$slash${clean.join(slash)}';
    printDebug('#### going to path: $path');

    if (path == '/') {
      path = '/chats';
    }
    PageManager().lastExtra.addAll(query ?? {});
    PageManager().context.go(path);
  }
}
