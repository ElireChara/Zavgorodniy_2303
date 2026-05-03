import 'dart:io';
import '../lib/classes/Machine.dart';
import '../lib/classes/Resources.dart';
import '../lib/classes/enums.dart';

void main() async {
  Machine machine = Machine(
    resources: Resources(coffeeBeans: 200, milk: 300, water: 500),
    cash: 0,
  );

  print('Добро пожаловать в современную кофемашину!');
  print('Доступны два режима приготовления:');
  print('  - синхронное (мгновенное, без задержек)');
  print('  - асинхронное (с имитацией реальных процессов)');

  bool exit = false;
  while (!exit) {
    print('\n===== МЕНЮ =====');
    print('1. Посмотреть состояние');
    print('2. Добавить ресурсы');
    print('3. Приготовить кофе (синхронно)');
    print('4. Приготовить кофе (асинхронно)');
    print('5. Забрать выручку');
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
        // Синхронное приготовление
        CoffeeType? type = _selectCoffeeType();
        if (type == null) continue;
        if (machine.isAvailable(type)) {
          bool success = machine.makeCoffee(type);
          if (success) {
            print('${_typeToString(type)} приготовлен! Спасибо!');
          } else {
            print('Не удалось приготовить кофе.');
          }
        } else {
          print('Недостаточно ресурсов для выбранного кофе.');
        }
        break;
      case '4':
        // Асинхронное приготовление
        CoffeeType? type = _selectCoffeeType();
        if (type == null) continue;
        if (machine.isAvailable(type)) {
          bool success = await machine.makeCoffeeAsync(type);
          if (!success) {
            print('Не удалось приготовить кофе.');
          }
        } else {
          print('Недостаточно ресурсов для выбранного кофе.');
        }
        break;
      case '5':
        int taken = machine.withdrawCash();
        print('Вы забрали $taken руб. из кофемашины.');
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

CoffeeType? _selectCoffeeType() {
  print('Выберите вид кофе:');
  print('1 - Эспрессо');
  print('2 - Капучино');
  print('3 - Американо');
  stdout.write('Ваш выбор: ');
  String? input = stdin.readLineSync();
  switch (input) {
    case '1':
      return CoffeeType.espresso;
    case '2':
      return CoffeeType.cappuccino;
    case '3':
      return CoffeeType.americano;
    default:
      print('Неверный выбор.');
      return null;
  }
}

String _typeToString(CoffeeType type) {
  switch (type) {
    case CoffeeType.espresso:
      return 'Эспрессо';
    case CoffeeType.cappuccino:
      return 'Капучино';
    case CoffeeType.americano:
      return 'Американо';
  }
}
