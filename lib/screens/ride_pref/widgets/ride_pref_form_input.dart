import 'package:blablacar/theme/theme.dart';
import 'package:blablacar/widgets/actions/bla_icon_button.dart';
import 'package:flutter/material.dart';

class RidePrefFormInput extends StatelessWidget {
  final IconData leftIcon;

  final String title;
  final VoidCallback onPressed;

  final IconData? rightIcon;
  final VoidCallback? onRightIconPressed;
  const RidePrefFormInput({
    super.key,
    required this.title,
    required this.leftIcon,
    required this.onPressed,
    this.rightIcon,
    this.onRightIconPressed,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: onPressed,

      splashColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,

      title: Text(
        title,
        style: BlaTextStyles.body.copyWith(color: BlaColors.textNormal),
      ),

      leading: Icon(leftIcon, color: BlaColors.iconLight),
      trailing: rightIcon != null
          ? BlaIconButton(
              onPressed: onRightIconPressed ?? () {},
              icon: rightIcon!,
            )
          : null,

      mouseCursor: SystemMouseCursors.click,
    );
  }
}
