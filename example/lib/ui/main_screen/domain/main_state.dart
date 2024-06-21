import 'package:example/data/model/generated/model.g.dart';

class MainState extends MainStateGen {
  @override
  @Field(name: 'counter')
  int counter = 0;

  MainState();
}
