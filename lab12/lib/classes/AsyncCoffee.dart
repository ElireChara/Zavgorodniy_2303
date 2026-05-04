import 'dart:async';

class AsyncCoffee {
  // 1. Нагрев воды – задержка 3 секунды
  static Future<void> heatWater() async {
    print('Нагрев воды...');
    await Future.delayed(Duration(seconds: 3));
    print('Вода нагрета.');
  }

  // 2. Заваривание кофе – задержка 5 секунд (выполняется после нагрева)
  static Future<void> brewCoffee() async {
    print('Заваривание кофе...');
    await Future.delayed(Duration(seconds: 5));
    print('Кофе заварен.');
  }

  // 3. Взбивание молока – задержка 5 секунд (запускается параллельно с завариванием)
  static Future<void> frothMilk() async {
    print('Взбивание молока...');
    await Future.delayed(Duration(seconds: 5));
    print('Молоко взбито.');
  }

  // 4. Смешивание кофе с молоком – задержка 3 секунды (после заваривания и взбивания)
  static Future<void> mix() async {
    print('Смешивание кофе с молоком...');
    await Future.delayed(Duration(seconds: 3));
    print('Смешивание завершено.');
  }
}
