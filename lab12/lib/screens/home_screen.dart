import 'package:flutter/material.dart';
import 'coffee_tab.dart';
import 'resources_tab.dart';
import '../classes/Machine.dart';
import '../classes/Resources.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late Machine machine;

  @override
  void initState() {
    super.initState();
    machine = Machine(
      resources: Resources(coffeeBeans: 200, milk: 300, water: 500),
      cash: 0,
      onStateChanged: () => setState(() {}), // обновление UI
    );
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Кофемашина'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.coffee), text: 'Приготовление'),
              Tab(icon: Icon(Icons.storage), text: 'Ресурсы'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            CoffeeTab(machine: machine),
            ResourcesTab(machine: machine),
          ],
        ),
      ),
    );
  }
}
