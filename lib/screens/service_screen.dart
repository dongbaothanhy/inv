import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Dịch vụ',
      icon: Icons.miscellaneous_services_outlined,
      onFabPressed: () {
        // Xử lý thêm dịch vụ
      },
    );
  }
}
