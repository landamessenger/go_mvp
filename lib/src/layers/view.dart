import 'package:flutter/material.dart';

import 'presenter.dart';
import '../widget/state_interface.dart';

abstract class View extends StateInterface {
  List<Widget> actions() {
    return <Widget>[];
  }

  void refresh(Presenter presenter);
}
