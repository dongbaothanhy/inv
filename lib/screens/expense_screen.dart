import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';
import 'add_expense_screen.dart';

class ExpenseScreen extends StatelessWidget {
  const ExpenseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Chi phí',
      icon: Icons.attach_money,
      showSearchBar: false,
      onFabPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddExpenseScreen()),
        );
      },
    );
  }
}
