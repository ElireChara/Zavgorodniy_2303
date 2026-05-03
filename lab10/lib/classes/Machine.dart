import 'Resources.dart';
import 'coffee/ICoffee.dart';
import 'coffee/CoffeeFactory.dart';
import 'enums.dart';

class Machine {
  Resources resources;
  int cash;

  Machine({required this.resources, this.cash = 0});

  int get coffeeBeans => resources.coffeeBeans;
  int get milk => resources.milk;
  int get water => resources.water;

  bool isAvailable(CoffeeType type) {
    final coffee = CoffeeFactory.createCoffee(type);
    if (coffee == null) return false;
    return resources.hasEnoughFor(coffee);
  }

  bool makeCoffee(CoffeeType type) {
    final coffee = CoffeeFactory.createCoffee(type);
    if (coffee == null) return false;
    if (!resources.hasEnoughFor(coffee)) return false;
    resources.subtract(coffee);
    cash += coffee.price();
    return true;
  }

  void addResources({int coffeeBeans = 0, int milk = 0, int water = 0}) {
    resources.add(coffeeBeans: coffeeBeans, milk: milk, water: water);
  }

  int withdrawCash() {
    int taken = cash;
    cash = 0;
    return taken;
  }

  void printStatus() {
    print('Состояние ресурсов:');
    resources.printStatus();
    print('Деньги в автомате: $cash руб.');
  }
}
