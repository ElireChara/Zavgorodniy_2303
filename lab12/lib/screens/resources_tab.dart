import 'package:flutter/material.dart';
import '../classes/Machine.dart';

class ResourcesTab extends StatefulWidget {
  final Machine machine;
  const ResourcesTab({super.key, required this.machine});

  @override
  State<ResourcesTab> createState() => _ResourcesTabState();
}

class _ResourcesTabState extends State<ResourcesTab> {
  final TextEditingController _coffeeController = TextEditingController();
  final TextEditingController _milkController = TextEditingController();
  final TextEditingController _waterController = TextEditingController();

  void _addResources() {
    int coffee = int.tryParse(_coffeeController.text) ?? 0;
    int milk = int.tryParse(_milkController.text) ?? 0;
    int water = int.tryParse(_waterController.text) ?? 0;

    if (coffee == 0 && milk == 0 && water == 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Введите хотя бы одно значение')),
      );
      return;
    }
    widget.machine.addResources(coffeeBeans: coffee, milk: milk, water: water);
    _coffeeController.clear();
    _milkController.clear();
    _waterController.clear();
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Ресурсы добавлены'),
        backgroundColor: Colors.green,
      ),
    );
  }

  void _withdrawCash() {
    int taken = widget.machine.withdrawCash();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Вы забрали $taken руб.'),
        backgroundColor: Colors.blue,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final resources = widget.machine.getResources();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Текущие ресурсы
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  const Text(
                    'Текущие ресурсы',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  ListTile(
                    leading: const Icon(Icons.coffee),
                    title: const Text('Кофе'),
                    trailing: Text('${resources.coffeeBeans} г'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.water_drop),
                    title: const Text('Молоко'),
                    trailing: Text('${resources.milk} мл'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.water),
                    title: const Text('Вода'),
                    trailing: Text('${resources.water} мл'),
                  ),
                  ListTile(
                    leading: const Icon(Icons.attach_money),
                    title: const Text('Выручка'),
                    trailing: Text('${widget.machine.getCash()} руб'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Добавление ресурсов
          const Text(
            'Добавить ресурсы:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 12),
          TextField(
            controller: _coffeeController,
            decoration: const InputDecoration(labelText: 'Кофе (грамм)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _milkController,
            decoration: const InputDecoration(labelText: 'Молоко (мл)'),
            keyboardType: TextInputType.number,
          ),
          TextField(
            controller: _waterController,
            decoration: const InputDecoration(labelText: 'Вода (мл)'),
            keyboardType: TextInputType.number,
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: _addResources,
            child: const Text('Добавить'),
          ),
          const SizedBox(height: 24),
          // Забрать выручку
          ElevatedButton(
            onPressed: _withdrawCash,
            style: ElevatedButton.styleFrom(backgroundColor: Colors.orange),
            child: const Text('Забрать выручку'),
          ),
        ],
      ),
    );
  }
}
