import 'package:example/data/model/generated/model.g.dart';
import 'package:flutter/material.dart';
import 'package:go_mvp/go_mvp.dart';

import 'routes.dart';

void main() {
  AppManager().withRouterAndModel(router, Model());
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) => const AppWidget(
        title: "Example App",
      );
}
