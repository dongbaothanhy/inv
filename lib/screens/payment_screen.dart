import 'package:flutter/material.dart';
import '../widgets/empty_screen_layout.dart';
import 'add_payment_screen.dart';

class PaymentScreen extends StatelessWidget {
  const PaymentScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return EmptyScreenLayout(
      title: 'Thanh toán',
      icon: Icons.credit_card,
      onFabPressed: () {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => const AddPaymentScreen()),
        );
      },
    );
  }
}
