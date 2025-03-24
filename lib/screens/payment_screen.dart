import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Thanh toán',
      icon: Icons.credit_card_outlined,
      showSearchBar: false,
      onFabPressed: () {
        // Xử lý thêm thanh toán
      },
    );
  }
}
