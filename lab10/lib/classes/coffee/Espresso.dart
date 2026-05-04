import 'ICoffee.dart';

class Espresso implements ICoffee {
  @override
  String name() => 'Эспрессо';

  @override
  int coffee() => 50;

  @override
  int milk() => 0;

  @override
  int water() => 100;

  @override
  int price() => 100;
}
