import 'ICoffee.dart';

class Cappuccino implements ICoffee {
  @override
  String name() => 'Капучино';

  @override
  int coffee() => 50;

  @override
  int milk() => 150;

  @override
  int water() => 50;

  @override
  int price() => 150;
}
