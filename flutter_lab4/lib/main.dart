import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Кампус КубГАУ',
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const CampusDetailScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class CampusDetailScreen extends StatefulWidget {
  const CampusDetailScreen({super.key});

  @override
  State<CampusDetailScreen> createState() => _CampusDetailScreenState();
}

class _CampusDetailScreenState extends State<CampusDetailScreen> {
  // Состояние для сердечка (избранное)
  bool _isLiked = false;

  // Обработчик нажатия на сердечко
  void _toggleLike() {
    setState(() {
      _isLiked = !_isLiked;
    });
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          _isLiked ? 'Добавлено в избранное' : 'Удалено из избранного',
        ),
        duration: const Duration(milliseconds: 800),
      ),
    );
  }

  void _call() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Звонок по номеру +7 (861) 221-58-58'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _route() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Построение маршрута до кампуса КубГАУ'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  void _share() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Text('Открыт диалог поделиться информацией'),
        duration: Duration(seconds: 2),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Кампус Кубанского ГАУ'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white, // иконки и текст на панели белые
        elevation: 4,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Изображение кампуса (сетевое)
            ClipRRect(
              borderRadius: BorderRadius.circular(12),
              child: Image.asset(
                'assets/20obsh.jpg',
                height: 200,
                width: double.infinity,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) => Container(
                  height: 200,
                  color: Colors.green.shade100,
                  child: const Center(
                    child: Icon(
                      Icons.broken_image,
                      size: 50,
                      color: Colors.green,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Строка с заголовком и сердечком
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: Text(
                    'Студенческий городок КубГАУ',
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                // Кнопка-сердечко (красное, меняет состояние)
                IconButton(
                  icon: Icon(
                    _isLiked ? Icons.favorite : Icons.favorite_border,
                    color: Colors.red,
                    size: 32,
                  ),
                  onPressed: _toggleLike,
                  tooltip: 'В избранное',
                ),
              ],
            ),
            const SizedBox(height: 8),

            // Краткий рейтинг или дополнительная информация (опционально)
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.green.shade700),
                const SizedBox(width: 4),
                Text(
                  'г. Краснодар, ул. Калинина, 13',
                  style: TextStyle(color: Colors.grey.shade700),
                ),
              ],
            ),
            const SizedBox(height: 16),

            // Длинный текст (по заданию)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  'Студенческий городок или так называемый кампус Кубанского ГАУ состоит из двадцати общежитий, в которых проживает более 8000 студентов, что составляет 96% от всех нуждающихся. Студенты первого курса обеспечены местами в общежитии полностью. В соответствии с Положением о студенческих общежитиях университета, при поселении между администрацией и студентами заключается договор найма жилого помещения. Воспитательная работа в общежитиях направлена на улучшение быта, соблюдение правил внутреннего распорядка, отсутствия асоциальных явлений в молодежной среде. Условия проживания в общежитиях университетского кампуса полностью отвечают санитарным нормам и требованиям: наличие оборудованных кухонь, душевых комнат, прачечных, читальных залов, комнат самоподготовки, помещений для заседаний студенческих советов и наглядной агитации. С целью улучшения условий быта студентов активно работает система студенческого самоуправления - студенческие советы организуют всю работу по самообслуживанию.',
                  style: TextStyle(fontSize: 16, height: 1.4),
                  textAlign: TextAlign.justify,
                ),
              ),
            ),
            const SizedBox(height: 24),

            // Три кнопки действий: Позвонить, Маршрут, Поделиться
            // Иконки кнопок – зеленые (в соответствии с заданием)
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                // Кнопка "Позвонить"
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.phone,
                    label: 'Позвонить',
                    color: Colors.green,
                    onPressed: _call,
                  ),
                ),
                const SizedBox(width: 12),
                // Кнопка "Маршрут"
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.directions,
                    label: 'Маршрут',
                    color: Colors.green,
                    onPressed: _route,
                  ),
                ),
                const SizedBox(width: 12),
                // Кнопка "Поделиться"
                Expanded(
                  child: _buildActionButton(
                    icon: Icons.share,
                    label: 'Поделиться',
                    color: Colors.green,
                    onPressed: _share,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // Вспомогательный метод для создания стилизованной кнопки с зеленой иконкой и текстом
  Widget _buildActionButton({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onPressed,
  }) {
    return OutlinedButton.icon(
      onPressed: onPressed,
      icon: Icon(icon, color: color),
      label: Text(label, style: TextStyle(color: color)),
      style: OutlinedButton.styleFrom(
        side: BorderSide(color: color),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        padding: const EdgeInsets.symmetric(vertical: 12),
      ),
    );
  }
}
