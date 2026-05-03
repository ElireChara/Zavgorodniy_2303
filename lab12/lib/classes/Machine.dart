import 'Resources.dart';
import 'coffee/ICoffee.dart';
import 'coffee/CoffeeFactory.dart';
import 'enums.dart';
import 'AsyncCoffee.dart';
import 'package:flutter/foundation.dart';

class Machine {
  Resources resources;
  int cash;
  VoidCallback? onStateChanged; // для уведомления UI

  Machine({required this.resources, this.cash = 0, this.onStateChanged});

  void _notify() {
    if (onStateChanged != null) onStateChanged!();
  }

  bool makeCoffee(CoffeeType type) {
    final coffee = CoffeeFactory.createCoffee(type);
    if (coffee == null) return false;
    if (!resources.hasEnoughFor(coffee)) return false;
    resources.subtract(coffee);
    cash += coffee.price();
    _notify();
    return true;
  }

  Future<bool> makeCoffeeAsync(CoffeeType type) async {
    final coffee = CoffeeFactory.createCoffee(type);
    if (coffee == null) return false;
    if (!resources.hasEnoughFor(coffee)) return false;

    if (coffee.milk() > 0) {
      await AsyncCoffee.heatWater();
      await Future.wait([AsyncCoffee.brewCoffee(), AsyncCoffee.frothMilk()]);
      await AsyncCoffee.mix();
    } else {
      await AsyncCoffee.heatWater();
      await AsyncCoffee.brewCoffee();
    }
    resources.subtract(coffee);
    cash += coffee.price();
    _notify();
    return true;
  }

  bool isAvailable(CoffeeType type) {
    final coffee = CoffeeFactory.createCoffee(type);
    if (coffee == null) return false;
    return resources.hasEnoughFor(coffee);
  }

  void addResources({int coffeeBeans = 0, int milk = 0, int water = 0}) {
    resources.add(coffeeBeans: coffeeBeans, milk: milk, water: water);
    _notify();
  }

  int withdrawCash() {
    int taken = cash;
    cash = 0;
    _notify();
    return taken;
  }

  Resources getResources() => resources;
  int getCash() => cash;
}
