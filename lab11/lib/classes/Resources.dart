import 'coffee/ICoffee.dart';

class Resources {
  int coffeeBeans;
  int milk;
  int water;

  Resources({
    required this.coffeeBeans,
    required this.milk,
    required this.water,
  });

  bool hasEnoughFor(ICoffee coffee) {
    return coffeeBeans >= coffee.coffee() &&
           milk >= coffee.milk() &&
           water >= coffee.water();
  }

  void subtract(ICoffee coffee) {
    coffeeBeans -= coffee.coffee();
    milk -= coffee.milk();
    water -= coffee.water();
  }

  void add({int coffeeBeans = 0, int milk = 0, int water = 0}) {
    this.coffeeBeans += coffeeBeans;
    this.milk += milk;
    this.water += water;
  }

  void printStatus() {
    print('Кофе: $coffeeBeans г, Молоко: $milk мл, Вода: $water мл');
  }
}