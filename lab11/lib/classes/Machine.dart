import 'Resources.dart';
import 'coffee/ICoffee.dart';
import 'coffee/CoffeeFactory.dart';
import 'enums.dart';
import 'AsyncCoffee.dart';

class Machine {
  Resources resources;
  int cash;

  Machine({required this.resources, this.cash = 0});

  bool makeCoffee(CoffeeType type) {
    final coffee = CoffeeFactory.createCoffee(type);
    if (coffee == null) return false;
    if (!resources.hasEnoughFor(coffee)) return false;
    resources.subtract(coffee);
    cash += coffee.price();
    return true;
  }

  // Асинхронное приготовление с выводом технических сообщений
  Future<bool> makeCoffeeAsync(CoffeeType type) async {
    final coffee = CoffeeFactory.createCoffee(type);
    if (coffee == null) return false;
    if (!resources.hasEnoughFor(coffee)) return false;

    print('\n☕ Готовим ${coffee.name()}...');

    // 1. Нагрев воды
    await AsyncCoffee.heatWater();

    if (coffee.milk() > 0) {
      // Кофе с молоком: заваривание и взбивание молока параллельно
      final brewFuture = AsyncCoffee.brewCoffee();
      final frothFuture = AsyncCoffee.frothMilk();
      await Future.wait([brewFuture, frothFuture]); // ждём оба
      // 2. Смешивание
      await AsyncCoffee.mix();
    } else {
      // Кофе без молока: только заваривание
      await AsyncCoffee.brewCoffee();
      print('Смешивание не требуется (кофе без молока).');
    }

    // Списание ресурсов и добавление денег (после успешного приготовления)
    resources.subtract(coffee);
    cash += coffee.price();
    print('Напиток готов!');
    print('${coffee.name()} готов. Приятного аппетита!\n');
    return true;
  }

  bool isAvailable(CoffeeType type) {
    final coffee = CoffeeFactory.createCoffee(type);
    if (coffee == null) return false;
    return resources.hasEnoughFor(coffee);
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
