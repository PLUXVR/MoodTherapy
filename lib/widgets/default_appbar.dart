import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';

class DefaultAppBar extends StatelessWidget implements PreferredSizeWidget {
  const DefaultAppBar({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
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
    );
  }
  
  @override
  Size get preferredSize => const Size.fromHeight(60);
}