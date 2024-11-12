import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:to_do_app/core/resources/constants/colors.dart';
import 'package:to_do_app/feature/home_page/home.dart';
import 'package:to_do_app/feature/profile_page/profile.dart';
import 'package:to_do_app/feature/settings_page/settings.dart';
import 'package:to_do_app/core/widgets/outlined_icon.dart';

class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<StatefulWidget> createState() => _BottomNavBar();
}

class _BottomNavBar extends State<BottomNavBar> {
  int _page = 1;

  final _pageOption = [
    const ProfileApp(),
    const Home(),
    const Settings(),
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

        color: tdYellow,
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
