import 'dart:io';
import '../lib/classes/Machine.dart';

void main() {
  Machine machine = Machine(200, 300, 500, 0);

  print('Добро пожаловать в кофемашину!');

  bool exit = false;
  while (!exit) {
    print('\n===== МЕНЮ =====');
    print('1. Посмотреть состояние ресурсов');
    print('2. Добавить ресурсы');
    print('3. Приготовить эспрессо');
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
        machine.addCoffee(coffee);

        stdout.write('Молоко (мл): ');
        int milk = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        machine.addMilk(milk);

        stdout.write('Вода (мл): ');
        int water = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        machine.addWater(water);

        stdout.write('Деньги в купюроприемник (руб): ');
        int cash = int.tryParse(stdin.readLineSync() ?? '0') ?? 0;
        machine.addCash(cash);

        print('Ресурсы добавлены.');
        break;

      case '3':
        if (machine.makingCoffee()) {
          print('Эспрессо приготовлен! Стоимость 100 руб. Спасибо!');
        } else {
          print(
            'Недостаточно ресурсов для приготовления эспрессо (нужно 50 г кофе и 100 мл воды)',
          );
        }
        break;

      case '4':
        int taken = machine.withdrawCash();
        print('Вы забрали $taken руб. из кофемашины.');
        break;

      case '0':
        exit = true;
        print('До свидания!');
        break;

      default:
        print('Неверный ввод, попробуйте снова.');
    }
  }
}
