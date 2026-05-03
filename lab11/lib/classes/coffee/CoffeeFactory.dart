import 'ICoffee.dart';
import 'Espresso.dart';
import 'Cappuccino.dart';
import 'Americano.dart';
import '../enums.dart';

class CoffeeFactory {
  static ICoffee? createCoffee(CoffeeType type) {
    switch (type) {
      case CoffeeType.espresso:
        return Espresso();
      case CoffeeType.cappuccino:
        return Cappuccino();
      case CoffeeType.americano:
        return Americano();
    }
  }
}
