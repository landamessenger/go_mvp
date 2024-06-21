import 'package:flutter/material.dart';
import 'package:go_mvp/go_mvp.dart';

import 'routes.dart';

void main() {
  PageManager().router = router;
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: router,
      key: PageManager().global,
      scaffoldMessengerKey: PageManager().key,
      title: "Example App",
    );
  }
}
