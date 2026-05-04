import 'package:flutter/material.dart';
import '../classes/Machine.dart';
import '../classes/enums.dart';

class CoffeeTab extends StatefulWidget {
  final Machine machine;
  const CoffeeTab({super.key, required this.machine});

  @override
  State<CoffeeTab> createState() => _CoffeeTabState();
}

class _CoffeeTabState extends State<CoffeeTab> {
  bool _isProcessing = false;

  Future<void> _makeCoffee(CoffeeType type, bool asyncMode) async {
    if (_isProcessing) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Подождите, операция уже выполняется')),
      );
      return;
    }

    if (!widget.machine.isAvailable(type)) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Недостаточно ресурсов!'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    setState(() => _isProcessing = true);

    try {
      bool success;
      if (asyncMode) {
        success = await widget.machine.makeCoffeeAsync(type);
      } else {
        success = widget.machine.makeCoffee(type);
      }

      if (!success) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(
            content: Text('Ошибка приготовления'),
            backgroundColor: Colors.red,
          ),
        );
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text('${_typeName(type)} готов! Приятного аппетита!'),
            backgroundColor: Colors.green,
          ),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Ошибка: $e'), backgroundColor: Colors.red),
      );
    } finally {
      setState(() => _isProcessing = false);
    }
  }

  String _typeName(CoffeeType type) {
    switch (type) {
      case CoffeeType.espresso:
        return 'Эспрессо';
      case CoffeeType.cappuccino:
        return 'Капучино';
      case CoffeeType.americano:
        return 'Американо';
    }
  }

  @override
  Widget build(BuildContext context) {
    final resources = widget.machine.getResources();
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Дисплей – отображение ресурсов
          Card(
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                children: [
                  Text(
                    'Состояние ресурсов',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _infoChip('Кофе', '${resources.coffeeBeans} г'),
                      _infoChip('Молоко', '${resources.milk} мл'),
                      _infoChip('Вода', '${resources.water} мл'),
                      _infoChip('Выручка', '${widget.machine.getCash()} руб'),
                    ],
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 24),
          // Кнопки выбора кофе
          Text(
            'Выберите напиток:',
            style: Theme.of(context).textTheme.titleMedium,
          ),
          const SizedBox(height: 12),
          for (var type in CoffeeType.values)
            Card(
              margin: const EdgeInsets.symmetric(vertical: 6),
              child: Padding(
                padding: const EdgeInsets.all(12),
                child: Row(
                  children: [
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            _typeName(type),
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 18,
                            ),
                          ),
                          const SizedBox(height: 4),
                          if (type == CoffeeType.espresso)
                            const Text('50г кофе, 100мл воды – 100 руб'),
                          if (type == CoffeeType.cappuccino)
                            const Text(
                              '50г кофе, 150мл молока, 50мл воды – 150 руб',
                            ),
                          if (type == CoffeeType.americano)
                            const Text('50г кофе, 150мл воды – 120 руб'),
                        ],
                      ),
                    ),
                    Column(
                      children: [
                        ElevatedButton(
                          onPressed: _isProcessing
                              ? null
                              : () => _makeCoffee(type, false),
                          child: const Text('Синхронно'),
                        ),
                        const SizedBox(height: 6),
                        ElevatedButton(
                          onPressed: _isProcessing
                              ? null
                              : () => _makeCoffee(type, true),
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.green,
                          ),
                          child: const Text('Асинхронно'),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          if (_isProcessing)
            const Padding(
              padding: EdgeInsets.all(16),
              child: Center(child: CircularProgressIndicator()),
            ),
        ],
      ),
    );
  }

  Widget _infoChip(String label, String value) {
    return Chip(label: Text('$label: $value'));
  }
}
