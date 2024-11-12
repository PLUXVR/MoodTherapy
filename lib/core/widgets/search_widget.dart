import 'package:flutter/material.dart';
import 'package:to_do_app/core/resources/constants/colors.dart';

class SearchWidget extends StatelessWidget {
  final Function(String) filterFunction;

  const SearchWidget({
    super.key,
    required this.filterFunction,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          // Горизонтальные отступы от краев экрана
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Container(
            // Отступ от края в текстовом поле
            padding: const EdgeInsets.symmetric(horizontal: 15),
            decoration: BoxDecoration(
                color: Colors.white, borderRadius: BorderRadius.circular(20)),
            child: TextField(
              onChanged: (value) => filterFunction(value),
              decoration: const InputDecoration(
                  contentPadding: EdgeInsets.all(3),
                  // Иконка лупы в строке поиска
                  prefixIcon: Icon(
                    Icons.search,
                    color: tdBlack,
                    size: 20,
                  ),
                  prefixIconConstraints:
                      BoxConstraints(maxHeight: 20, minWidth: 25),
                  // Отсутствие линии нижней грани
                  border: InputBorder.none,
                  hintText: 'Поиск',
                  hintStyle: TextStyle(color: tdGrey)),
            ),
          ),
        )
      ],
    );
  }
}