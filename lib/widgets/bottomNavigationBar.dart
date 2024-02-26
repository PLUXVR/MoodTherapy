import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/constants/colors.dart';
import 'package:to_do_app/screens/home.dart';
import 'package:to_do_app/screens/profile.dart';
import 'package:to_do_app/screens/settings.dart';
import 'package:to_do_app/widgets/outlined_icon.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _page = 1;

  final _pageOption = [
    ProfileApp(),
    const Home(),
    Settings(),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
        index: 1,
        items: const <Widget>[
          OutlinedIcon(Icons.person, color: tdTeal),
          OutlinedIcon(Icons.add_circle_outline, color: tdTeal),
          OutlinedIcon(Icons.settings, color: tdTeal),
        ],
        backgroundColor: tdBGColor,
        color: const Color.fromARGB(255, 248, 216, 75),
        onTap: (index) {
          setState(() {
            _page = index;
          });
        },
      ),
      body: _pageOption[_page],
    );
  }
}
