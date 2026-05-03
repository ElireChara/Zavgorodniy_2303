import 'package:flutter/material.dart';

class SimpleListScreen extends StatelessWidget {
  const SimpleListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Простой список')),
      body: ListView(
        children: const [
          ListTile(title: Text('Элемент 1')),
          ListTile(title: Text('Элемент 2')),
          ListTile(title: Text('Элемент 3')),
        ],
      ),
    );
  }
}
