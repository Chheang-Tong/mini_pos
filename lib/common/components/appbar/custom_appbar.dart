import 'package:flutter/material.dart';

import '../../../core/core.dart';

class CustomAppBar extends StatefulWidget implements PreferredSizeWidget {
  final Widget? title;
  final Widget? lead;
  final Widget? action;
  final Color? backgroundColor;
  const CustomAppBar({
    super.key,
    this.title,
    this.lead,
    this.action,
    this.backgroundColor,
  });
  @override
  Size get preferredSize => const Size.fromHeight(kToolbarHeight);

  @override
  State<CustomAppBar> createState() => _CustomAppBarState();
}

class _CustomAppBarState extends State<CustomAppBar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: SafeArea(
        child: Container(
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: Dimensions.space16),
          child: Row(
            children: [
              if (widget.lead != null) widget.lead!,
              if (widget.title != null) Expanded(child: widget.title!),
              if (widget.title == null) const Spacer(),
              if (widget.action != null) widget.action!,
            ],
          ),
        ),
      ),
    );
  }
}
