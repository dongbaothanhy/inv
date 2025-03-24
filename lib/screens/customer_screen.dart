import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';
import 'add_customer_screen.dart';

class CustomerScreen extends StatelessWidget {
  const CustomerScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Khách hàng',
      icon: Icons.person_outline,
      appBarActions: [
        IconButton(
          icon: const Icon(Icons.search, color: Colors.white),
          onPressed: () {
            // Xử lý tìm kiếm
          },
        ),
      ],
      onFabPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddCustomerScreen()),
        );
      },
    );
  }
}
