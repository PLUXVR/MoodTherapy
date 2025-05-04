import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:to_do_app/core/resources/constants/colors.dart';

class MotivatedItem extends StatefulWidget {
  const MotivatedItem({super.key});

  @override
  State<MotivatedItem> createState() => _MotivatedItemState();
}

class _MotivatedItemState extends State<MotivatedItem> {
  String quote = "Загрузка цитаты...";
  String author = "";
  bool isLoading = false;

  // Локальные цитаты на случай отсутствия интернета
  final List<Map<String, String>> offlineQuotes = [
    {
      "quote": "Дорогу осилит идущий",
      "author": "Древняя мудрость"
    },
    {
      "quote": "Не откладывай на завтра то, что можно сделать сегодня",
      "author": "Бенджамин Франклин"
    },
    {
      "quote": "Успех — это способность идти от неудачи к неудаче, не теряя энтузиазма",
      "author": "Уинстон Черчилль"
    },
    {
      "quote": "Лучший способ предсказать будущее — создать его",
      "author": "Авраам Линкольн"
    },
  ];

  @override
  void initState() {
    super.initState();
    fetchRandomQuote();
  }

  Future<void> fetchRandomQuote() async {
    setState(() {
      isLoading = true;
    });

    try {
      // Используем API для русскоязычных цитат
      final response = await http.get(
        Uri.parse('https://api.forismatic.com/api/1.0/?method=getQuote&format=json&lang=ru'),
      );

      if (response.statusCode == 200) {
        final data = json.decode(utf8.decode(response.bodyBytes)); // Для корректного отображения кириллицы
        setState(() {
          quote = data['quoteText'] ?? "Цитата не найдена";
          author = data['quoteAuthor']?.toString().trim() ?? "Неизвестный автор";
          
          // Если автор не указан, заменяем на "Неизвестный автор"
          if (author.isEmpty) author = "Неизвестный автор";
        });
      } else {
        useOfflineQuote();
      }
    } catch (e) {
      print('Ошибка при получении цитаты: $e');
      useOfflineQuote();
    } finally {
      setState(() {
        isLoading = false;
      });
    }
  }

  void useOfflineQuote() {
    final randomQuote = offlineQuotes[DateTime.now().second % offlineQuotes.length];
    setState(() {
      quote = randomQuote['quote']!;
      author = randomQuote['author']!;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 20,),
      elevation: 2,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
      child: Padding(
        padding: const EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            if (isLoading)
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 12),
                child: Center(child: CircularProgressIndicator()),
              )
            else
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    '"$quote"',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black87,
                      fontStyle: FontStyle.italic,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    '- $author',
                    style: TextStyle(
                      fontSize: 14,
                      color: Colors.blueGrey[800],
                      fontWeight: FontWeight.bold,
                    ),
                    textAlign: TextAlign.right,
                  ),
                ],
              ),
            const SizedBox(height: 8),
            Align(
              alignment: Alignment.centerRight,
              child: IconButton(
                icon: Icon(Icons.refresh, color: tdRed),
                onPressed: fetchRandomQuote,
                tooltip: 'Новая цитата',
              ),
            ),
          ],
        ),
      ),
    );
  }
}