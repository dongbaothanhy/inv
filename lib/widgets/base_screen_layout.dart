import 'package:flutter/material.dart';
import 'custom_app_bar.dart';
import 'custom_fab.dart';

class BaseScreenLayout extends StatelessWidget {
  final String title;
  final List<Widget>? appBarActions;
  final Widget? body;
  final VoidCallback? onFabPressed;
  final bool showFab;
  final bool showBackButton;

  const BaseScreenLayout({
    super.key,
    required this.title,
    this.appBarActions,
    this.body,
    this.onFabPressed,
    this.showFab = true,
    this.showBackButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: CustomAppBar(
        title: title,
        actions: appBarActions,
        showBackButton: showBackButton,
      ),
      body: Stack(
        children: [
          if (body != null) body!,
          if (showFab && onFabPressed != null)
            CustomFAB(onPressed: onFabPressed!),
        ],
      ),
    );
  }
}
