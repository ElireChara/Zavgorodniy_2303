import 'package:flutter/material.dart';

class InfinityListScreen extends StatelessWidget {
  const InfinityListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Бесконечный список')),
      body: ListView.builder(
        itemBuilder: (context, index) =>
            ListTile(title: Text('Строка ${index + 1}')),
      ),
    );
  }
}
