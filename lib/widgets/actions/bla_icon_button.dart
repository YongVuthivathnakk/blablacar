import 'package:blablacar/theme/theme.dart';
import 'package:flutter/material.dart';

class BlaIconButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final IconData? icon;
  const BlaIconButton({super.key, required this.onPressed, required this.icon});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: GestureDetector(
        onTap: onPressed,
        child: Icon(icon, size: BlaSize.icon, color: BlaColors.primary),
      ),
    );
  }
}
