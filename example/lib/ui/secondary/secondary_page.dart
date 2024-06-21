import 'package:flutter/material.dart';

import 'secondary_types.dart';
import 'presenter/secondary_presenter.dart';
import 'view/secondary_page_state.dart';

class SecondaryPage extends SecondaryWidget {
  static const String routeName = 'secondary';
  static const String tagStateName = '_SecondaryPageState';

  SecondaryPage({
    Key? key,
  }) : super(
          presenter: SecondaryPresenter(),
          key: const ValueKey(tagStateName),
          route: routeName,
          tagName: tagStateName,
        );

  @override
  SecondaryPageState createState() => SecondaryPageState();
}
