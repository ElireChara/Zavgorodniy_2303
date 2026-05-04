import 'dart:io';
import '../lib/classes/Machine.dart';
import '../lib/classes/Resources.dart';
import '../lib/classes/enums.dart';

void main() {
  Machine machine = Machine(
    resources: Resources(coffeeBeans: 200, milk: 300, water: 500),
    cash: 0,
  );

  print('Добро пожаловать в современную кофемашину!');

  bool exit = false;
  while (!exit) {
    print('\n===== МЕНЮ =====');
    print('1. Посмотреть состояние');
    print('2. Добавить ресурсы');
    print('3. Приготовить кофе');
    print('4. Забрать выручку');
    print('0. Выход');
    stdout.write('Ваш выбор: ');
    String? choice = stdin.readLineSync();

    switch (choice) {
      case '1':
        machine.printStatus();
        break;
      case '2':
        print('Добавление ресурсов:');
        stdout.write('Кофе (г): ');
        int coffee = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        stdout.write('Молоко (мл): ');
        int milk = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        stdout.write('Вода (мл): ');
        int water = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        machine.addResources(coffeeBeans: coffee, milk: milk, water: water);
        print('Ресурсы добавлены.');
        break;
      case '3':
        print('Выберите вид кофе:');
        print('1 - Эспрессо');
        print('2 - Капучино');
        print('3 - Американо');
        stdout.write('Ваш выбор: ');
        String? coffeeChoice = stdin.readLineSync();
        CoffeeType? type;
        switch (coffeeChoice) {
          case '1':
            type = CoffeeType.espresso;
            break;
          case '2':
            type = CoffeeType.cappuccino;
            break;
          case '3':
            type = CoffeeType.americano;
            break;
          default:
            print('Неверный выбор.');
            continue;
        }
        if (machine.isAvailable(type)) {
          if (machine.makeCoffee(type)) {
            print('${type.toString().split('.').last} приготовлен!');
          } else {
            print('Не удалось приготовить.');
          }
        } else {
          print('Недостаточно ресурсов.');
        }
        break;
      case '4':
        int taken = machine.withdrawCash();
        print('Вы забрали $taken руб.');
        break;
      case '0':
        exit = true;
        print('До свидания!');
        break;
      default:
        print('Неверный ввод.');
    }
  }
}
