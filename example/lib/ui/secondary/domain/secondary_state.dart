import 'package:example/data/model/generated/model.g.dart';

class SecondaryState extends SecondaryStateGen {
  @override
  @Field(name: 'counter')
  int counter = 0;

  SecondaryState();
}
