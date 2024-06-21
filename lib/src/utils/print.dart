import 'package:flutter/foundation.dart';

void printDebug(Object? object) {
  if (kDebugMode) {
    print(object);
  } else {
    // if (!kIsWeb && Firebase.apps.isNotEmpty) {
    // FirebaseCrashlytics.instance.log(object.toString());
    // }
  }
}
