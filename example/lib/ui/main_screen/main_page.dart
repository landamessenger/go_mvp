import 'package:flutter/material.dart';
import 'package:go_mvp/go_mvp.dart';

import 'presenter/main_presenter.dart';
import 'view/main_page_state.dart';

class MainPage extends WidgetInterface<MainPresenter, MainPage> {
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
