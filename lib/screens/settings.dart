import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';

class Settings extends StatefulWidget {
  const Settings({super.key});

  @override
  State<StatefulWidget> createState() => _Settings();
}

class _Settings extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Scaffold(
        backgroundColor: tdBGColor,
        appBar: AppBar(
          backgroundColor: tdBGColor,
          elevation: 0,
          title:
              // Для строки добавить расстояние между элементами и прибить их тем самым по краям строки
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
            const Icon(
              Icons.menu,
              color: tdBlack,
              size: 30,
            ),

            // Контейнер для фото профиля
            SizedBox(
              height: 40,
              width: 40,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                // Прежде чем использовать, необходимо прописать ссылку в pubspec
                child: Image.asset('assets/images/avatar.jpeg'),
              ),
            )
          ]),
        ),
        body: Stack(
          children: [
            Container(
              // Отступ от аппбара
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: const Center(
                child: Column(
                  children: [
                    // TODO менять версию при изменениях
                    Text(
                      'Версия приложения 1.0.3',
                      style: TextStyle(fontSize: 20),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
