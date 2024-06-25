import 'package:flutter/material.dart';

import 'api_types.dart';
import 'presenter/api_presenter.dart';
import 'view/api_page_state.dart';

class ApiPage extends ApiWidget {
  static const String routeName = 'api';
  static const String tagStateName = '_ApiPageState';

  ApiPage({
    Key? key,
  }) : super(
          presenter: ApiPresenter(),
          key: const ValueKey(tagStateName),
          route: routeName,
          tagName: tagStateName,
        );

  @override
  ApiPageState createState() => ApiPageState();
}

  