import 'package:flutter/material.dart';

class OutlinedIcon extends StatelessWidget {
  const OutlinedIcon(
    this.iconData, {
    super.key,
    this.color,
    this.size,
  });

  /// The iconData to be displayed
  final IconData iconData;

  /// The color of the icon
  final Color? color;

  /// The size of the icon
  final double? size;

  @override
  Widget build(BuildContext context) {
    return Icon(
      iconData,
      size: size,
      color: color,
      shadows: List.generate(
        5,
        (index) => const Shadow(
          blurRadius: 2,
          color: Colors.black54,
        ),
      ),
    );
  }
}
