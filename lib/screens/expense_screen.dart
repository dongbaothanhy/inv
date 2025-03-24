import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Chi phí',
      icon: Icons.attach_money,
      showSearchBar: false,
      onFabPressed: () {
        // Xử lý thêm chi phí
      },
    );
  }
}
