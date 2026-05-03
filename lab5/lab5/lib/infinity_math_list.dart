import 'package:flutter/material.dart';

class InfinityMathListScreen extends StatelessWidget {
  const InfinityMathListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Степени числа 2')),
      body: ListView.builder(
        itemBuilder: (context, index) {
          final power = BigInt.from(2).pow(index);
          return ListTile(
            leading: const Icon(Icons.calculate),
            title: Text('2 ^ $index'),
            trailing: Text(power.toString()),
          );
        },
      ),
    );
  }
}
