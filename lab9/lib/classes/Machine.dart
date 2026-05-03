class Machine {
  int _coffeeBeans = 0; // граммы
  int _milk = 0; // миллилитры
  int _water = 0; // миллилитры
  int _cash = 0; // рубли

  Machine(this._coffeeBeans, this._milk, this._water, this._cash);

  int get coffeeBeans => _coffeeBeans;
  set coffeeBeans(int value) => _coffeeBeans = value >= 0 ? value : 0;

  int get milk => _milk;
  set milk(int value) => _milk = value >= 0 ? value : 0;

  int get water => _water;
  set water(int value) => _water = value >= 0 ? value : 0;

  int get cash => _cash;
  set cash(int value) => _cash = value >= 0 ? value : 0;

  bool isAvailable() {
    return _coffeeBeans >= 50 && _water >= 100;
  }

  void _subtractResources() {
    _coffeeBeans -= 50;
    _water -= 100;
    _cash += 100;
  }

  bool makingCoffee() {
    if (isAvailable()) {
      _subtractResources();
      return true;
    } else {
      return false;
    }
  }

  void addCoffee(int grams) => _coffeeBeans += grams;
  void addMilk(int ml) => _milk += ml;
  void addWater(int ml) => _water += ml;
  void addCash(int amount) => _cash += amount;

  int withdrawCash() {
    int taken = _cash;
    _cash = 0;
    return taken;
  }

  void printStatus() {
    print(
      'Кофе: $_coffeeBeans г, Молоко: $_milk мл, Вода: $_water мл, Деньги: $_cash руб.',
    );
  }
}
