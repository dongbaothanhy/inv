import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import '../theme/colors.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String title;
  final List<Widget>? actions;
  final bool showBackButton;

  const CustomAppBar({
    super.key,
    required this.title,
    this.actions,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: AppColors.primary,
      leading:
          showBackButton
              ? IconButton(
                icon: const Icon(Icons.arrow_back, color: Colors.white),
                onPressed: () => Navigator.pop(context),
              )
              : null,
      title: Text(
        title,
        style: TextStyle(
          fontSize: ResponsiveHelper.getAdaptiveValue(
            context: context,
            desktop: 20.0,
            mobile: 18.0,
          ),
          fontWeight: FontWeight.w500,
          color: Colors.white,
        ),
      ),
      actions: actions,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(
    ResponsiveHelper.getAdaptiveValue(
      context: null,
      desktop: 64.0,
      mobile: 56.0,
    ),
  );
}
