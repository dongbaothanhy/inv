import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';

class ProductScreen extends StatelessWidget {
  const ProductScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Mặt hàng',
      icon: Icons.shopping_bag_outlined,
      onFabPressed: () {
        // Xử lý thêm mặt hàng
      },
    );
  }
}
