import 'package:flutter/material.dart';
import 'base_screen_layout.dart';

class EmptyScreenLayout extends StatelessWidget {
  final String title;
  final IconData icon;
  final List<Widget>? appBarActions;
  final VoidCallback? onFabPressed;
  final bool showSearchBar;

  const EmptyScreenLayout({
    super.key,
    required this.title,
    required this.icon,
    this.appBarActions,
    this.onFabPressed,
    this.showSearchBar = true,
  });

  @override
  Widget build(BuildContext context) {
    return BaseScreenLayout(
      title: title,
      appBarActions: appBarActions,
      body: Column(
        children: [
          if (showSearchBar)
            Container(
              padding: const EdgeInsets.all(16.0),
              child: TextField(
                decoration: InputDecoration(
                  hintText: 'Tìm kiếm',
                  prefixIcon: const Icon(Icons.search),
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(8.0),
                    borderSide: BorderSide.none,
                  ),
                  filled: true,
                  fillColor: Colors.grey[100],
                ),
              ),
            ),
          Expanded(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 100.0),
                child: Icon(icon, size: 64.0, color: const Color(0xFFa8c7fa)),
              ),
            ),
          ),
        ],
      ),
      onFabPressed: onFabPressed,
    );
  }
}
