import 'package:flutter/material.dart';
import 'package:badges/badges.dart' as badges;

class CustomBadge extends StatelessWidget {
  const CustomBadge({
    super.key,
    required this.icon,
    required this.color,
    required this.value,
    required this.isShow,
    required this.tap,
  });

  final Widget icon;
  final Color color;
  final String value;
  final bool isShow;
  final Function tap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => tap(),
      child: badges.Badge(
        position: badges.BadgePosition.topEnd(
          top: -8,
          end: -5,
        ),
        showBadge: isShow,
        ignorePointer: false,
        onTap: () {},
        badgeContent: Text(
          value,
          style: TextStyle(
            fontSize: 12,
            color: Colors.white,
          ),
        ),
        badgeAnimation: badges.BadgeAnimation.rotation(
          animationDuration: Duration(seconds: 1),
          colorChangeAnimationDuration: Duration(seconds: 1),
          loopAnimation: false,
          curve: Curves.fastOutSlowIn,
          colorChangeAnimationCurve: Curves.easeInCubic,
        ),
        badgeStyle: badges.BadgeStyle(
          shape: badges.BadgeShape.circle,
          badgeColor: Colors.blue,
          padding: EdgeInsets.all(4),
          borderRadius: BorderRadius.circular(4),
          // borderSide: BorderSide(color: Colors.white, width: 2),
          elevation: 0,
        ),
        child: icon
      ),
    );
  }
}