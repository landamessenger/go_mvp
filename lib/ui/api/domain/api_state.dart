import 'package:example/data/model/generated/model.g.dart';

class ApiState extends ApiStateGen {
  @override
  @Field(name: 'counter')
  int counter = 0;

  ApiState();
}

  