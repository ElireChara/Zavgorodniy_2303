import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:intl/intl.dart';

void main() => runApp(const MyApp());

// --- 1. Главный виджет приложения ---
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Новости КубГАУ',
      // Устанавливаем зеленую тему, как в задании
      theme: ThemeData(
        primarySwatch: Colors.green,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      debugShowCheckedModeBanner: false,
      home: const NewsListScreen(),
    );
  }
}

// --- 2. Экран со списком новостей ---
class NewsListScreen extends StatefulWidget {
  const NewsListScreen({super.key});

  @override
  State<NewsListScreen> createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsListScreen> {
  // Переменная, которая будет хранить результат асинхронной операции
  late Future<List<NewsArticle>> futureNews;

  @override
  void initState() {
    super.initState();
    // При запуске экрана начинаем загрузку новостей
    futureNews = fetchNews();
  }

  // --- 3. Функция для загрузки и парсинга новостей ---
  Future<List<NewsArticle>> fetchNews() async {
    // URL из методической работы
    final url = Uri.parse(
      'https://kubsau.ru/api/getNews.php?key=6df2f5d38d4e16b5a923a6d4873e2ee295d0ac90',
    );
    final response = await http.get(url);

    if (response.statusCode == 200) {
      // Если запрос успешен, парсим полученные данные
      return parseNews(response.body);
    } else {
      // Если ошибка, выбрасываем исключение, которое будет перехвачено в UI
      throw Exception('Не удалось загрузить новости');
    }
  }

  List<NewsArticle> parseNews(String responseBody) {
    // Декодируем JSON-строку
    final parsed = jsonDecode(responseBody);
    // API возвращает список новостей в корне. Преобразуем его в список объектов NewsArticle
    return parsed
        .map<NewsArticle>((json) => NewsArticle.fromJson(json))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // Верхняя панель приложения (AppBar) зеленого цвета
      appBar: AppBar(
        title: const Text('Лента новостей КубГАУ'),
        backgroundColor: Colors.green,
        foregroundColor: Colors.white,
        centerTitle: true,
      ),
      body: Center(
        // Виджет FutureBuilder ожидает завершения асинхронной операции и обновляет UI
        child: FutureBuilder<List<NewsArticle>>(
          future: futureNews,
          builder: (context, snapshot) {
            // Показываем индикатор загрузки, пока данные не получены
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            // Если произошла ошибка, показываем сообщение и кнопку для повторной попытки
            else if (snapshot.hasError) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error, size: 48, color: Colors.red),
                  const SizedBox(height: 16),
                  Text('Ошибка: ${snapshot.error}'),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        futureNews = fetchNews();
                      });
                    },
                    child: const Text('Повторить'),
                  ),
                ],
              );
            }
            // Если данные успешно загружены, отображаем их в виде списка карточек
            else if (snapshot.hasData) {
              return NewsList(articles: snapshot.data!);
            }
            return const Text('Нет новостей');
          },
        ),
      ),
    );
  }
}

// --- 4. Класс модели новости (хранит данные одной статьи) ---
class NewsArticle {
  final String id;
  final String title;
  final String previewText;
  final String date;
  final String detailUrl;
  final String imageUrl;

  const NewsArticle({
    required this.id,
    required this.title,
    required this.previewText,
    required this.date,
    required this.detailUrl,
    required this.imageUrl,
  });

  // Фабричный метод для создания объекта из JSON
  factory NewsArticle.fromJson(Map<String, dynamic> json) {
    // Используем функцию из пакета intl, чтобы очистить заголовок и текст от HTML-тегов и &nbsp;
    // Это один из ключевых моментов задания!
    String cleanTitle = Bidi.stripHtmlIfNeeded(
      json['TITLE'] ?? 'Без заголовка',
    );
    String cleanPreview = Bidi.stripHtmlIfNeeded(json['PREVIEW_TEXT'] ?? '');

    return NewsArticle(
      id: json['ID'].toString(),
      title: cleanTitle,
      previewText: cleanPreview.isNotEmpty ? cleanPreview : 'Подробнее...',
      date: json['ACTIVE_FROM'] ?? '',
      detailUrl: json['DETAIL_PAGE_URL'] ?? '',
      imageUrl: json['PREVIEW_PICTURE_SRC'] ?? '',
    );
  }
}

// --- 5. Виджет для отображения списка новостных карточек ---
class NewsList extends StatelessWidget {
  final List<NewsArticle> articles;
  const NewsList({super.key, required this.articles});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return Card(
          margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          elevation: 3,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Изображение новости (если есть)
                if (article.imageUrl.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      article.imageUrl,
                      height: 180,
                      width: double.infinity,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Container(
                        height: 180,
                        color: Colors.green.shade100,
                        child: const Center(
                          child: Icon(Icons.broken_image, size: 50),
                        ),
                      ),
                    ),
                  ),
                const SizedBox(height: 10),
                // Заголовок новости
                Text(
                  article.title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.green,
                  ),
                ),
                const SizedBox(height: 6),
                // Дата публикации
                if (article.date.isNotEmpty)
                  Text(
                    article.date,
                    style: TextStyle(fontSize: 12, color: Colors.grey.shade600),
                  ),
                const SizedBox(height: 8),
                // Краткий текст (preview)
                Text(
                  article.previewText,
                  maxLines: 3,
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(fontSize: 14),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
