import 'ICoffee.dart';

class Americano implements ICoffee {
  @override
  String name() => 'Американо';

  @override
  int coffee() => 50;

  @override
  int milk() => 0;

  @override
  int water() => 150;

  @override
  int price() => 120;
}
