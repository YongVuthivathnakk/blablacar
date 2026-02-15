import 'package:blablacar/theme/theme.dart';
import 'package:flutter/material.dart';

enum ButtonVariant { primary, secondary }

class BlaButton extends StatelessWidget {
  final ButtonVariant variant;
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool? isBorderRadius;
  final bool? isTopRadius;
  final bool? isSplashing;
  const BlaButton({
    super.key,
    this.variant = ButtonVariant.primary,
    required this.text,
    required this.onPressed,
    this.icon,
    this.isSplashing = true,
    this.isBorderRadius = true,
    this.isTopRadius = true,
  });

  @override
  Widget build(BuildContext context) {
    Color background = variant == ButtonVariant.primary
        ? BlaColors.primary
        : BlaColors.white;

    Color iconColor = variant == ButtonVariant.primary
        ? BlaColors.white
        : BlaColors.primary;

    BorderSide border = variant == ButtonVariant.primary
        ? BorderSide.none
        : BorderSide(color: BlaColors.greyLight, width: 2);

    List<Widget> children = [];
    if (icon != null) {
      children.add(Icon(icon, color: iconColor, size: 20));
      children.add(SizedBox(width: BlaSpacings.s));
    }

    BorderRadius borderRadius = isBorderRadius == true && isTopRadius == false
        ? BorderRadius.only(
            bottomLeft: Radius.circular(BlaSpacings.radius),
            bottomRight: Radius.circular(BlaSpacings.radius),
          )
        : isBorderRadius == true && isTopRadius == true
        ? BorderRadius.circular(BlaSpacings.radius)
        : BorderRadius.zero;

    Text buttonText = Text(
      text,
      style: TextStyle(
        color: variant == ButtonVariant.primary
            ? BlaColors.white
            : BlaColors.primary,
      ),
    );

    children.add(buttonText);

    return OutlinedButton(
      onPressed: onPressed,

      style: OutlinedButton.styleFrom(
        backgroundColor: background,

        padding: EdgeInsets.symmetric(vertical: 20),
        side: border,
        shape: RoundedRectangleBorder(borderRadius: borderRadius),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [...children],
      ),
    );
  }
}
