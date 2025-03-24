import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';
import 'add_service_screen.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Dịch vụ',
      icon: Icons.miscellaneous_services_outlined,
      onFabPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddServiceScreen()),
        );
      },
    );
  }
}
