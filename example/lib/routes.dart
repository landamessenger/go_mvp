import 'package:flutter/material.dart';
import 'package:go_mvp/go_mvp.dart';

import 'ui/main_screen/main_page.dart';

final router = GoRouter(
  initialLocation: '/',
  routes: [
    GoRoute(
      path: MainPage.routeName,
      pageBuilder: (context, state) => MainPage().pageFor(state),
    ),
  ],
  observers: [
    routeObserver,
  ],
  errorPageBuilder: (context, state) {
    return MaterialPage(
      key: state.pageKey,
      child: Scaffold(
        body: Center(
          child: Text(state.error.toString()),
        ),
      ),
    );
  },
);
