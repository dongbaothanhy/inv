import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';

class SupplierScreen extends StatelessWidget {
  const SupplierScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Nhà cung cấp',
      icon: Icons.business_outlined,
      onFabPressed: () {
        // Xử lý thêm nhà cung cấp
      },
    );
  }
}
