import 'package:flutter/material.dart';

import 'main_types.dart';
import 'presenter/main_presenter.dart';
import 'view/main_page_state.dart';

class MainPage extends MainWidget {
  static const String routeName = '/';
  static const String tagStateName = '_MainPageState';

  MainPage({
    Key? key,
  }) : super(
          presenter: MainPresenter(),
          key: const ValueKey(tagStateName),
          route: routeName,
          tagName: tagStateName,
        );

  @override
  MainPageState createState() => MainPageState();
}
