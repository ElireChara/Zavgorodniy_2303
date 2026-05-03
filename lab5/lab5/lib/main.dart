import 'package:flutter/material.dart';
import 'simple_list.dart';
import 'infinity_list.dart';
import 'infinity_math_list.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Лаб 5',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: const MenuScreen(),
    );
  }
}

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Лабораторная работа №5')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Кнопка 1 - прямоугольная
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const SimpleListScreen()),
                ),
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  side: const BorderSide(color: Colors.blue),
                ),
                child: const Text('Простой список'),
              ),
            ),
            const SizedBox(height: 16),
            // Кнопка 2 - прямоугольная
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (_) => const InfinityListScreen()),
                ),
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  side: const BorderSide(color: Colors.blue),
                ),
                child: const Text('Бесконечный список (строки)'),
              ),
            ),
            const SizedBox(height: 16),
            // Кнопка 3 - прямоугольная
            SizedBox(
              width: 250,
              child: OutlinedButton(
                onPressed: () => Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const InfinityMathListScreen(),
                  ),
                ),
                style: OutlinedButton.styleFrom(
                  shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.zero,
                  ),
                  side: const BorderSide(color: Colors.blue),
                ),
                child: const Text('Степени двойки'),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
