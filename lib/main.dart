import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/settings_menu_item.dart';
import '../screens/dashboard_screen.dart';
import '../screens/invoice_screen.dart';
import 'screens/quotation_screen.dart';
import 'screens/order_screen.dart';
import 'screens/customer_screen.dart';
import 'screens/product_screen.dart';
import 'screens/service_screen.dart';
import 'screens/expense_screen.dart';
import 'screens/payment_screen.dart';
import 'screens/report_screen.dart';
import 'screens/create_receipt_screen.dart';
import 'screens/settings_screen.dart';
import 'utils/responsive_helper.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      ),
      home: const ReceiptScreen(),
    );
  }
}

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  // Biến để theo dõi trạng thái mở rộng của các menu
  bool _isProductExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(
          ResponsiveHelper.getAdaptiveValue(
            context: context,
            desktop: 64.0,
            mobile: 56.0,
          ),
        ),
        child: AppBar(
          backgroundColor: const Color(0xFF4285f4),
          title: Text(
            'Biên lai',
            style: TextStyle(
              fontSize: ResponsiveHelper.getAdaptiveValue(
                context: context,
                desktop: 20.0,
                mobile: 18.0,
              ),
              fontWeight: FontWeight.w500,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              icon: Icon(
                Icons.search,
                size: ResponsiveHelper.getAdaptiveValue(
                  context: context,
                  desktop: 24.0,
                  mobile: 20.0,
                ),
              ),
              onPressed: () {},
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: SafeArea(
          child: Container(
            color: AppColors.background,
            child: Column(
              children: [
                Container(
                  color: AppColors.primary,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16.0,
                    vertical: 16.0,
                  ),
                  child: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SettingsScreen(),
                        ),
                      );
                    },
                    child: Row(
                      children: [
                        const Icon(
                          Icons.settings,
                          color: AppColors.white,
                          size: 24,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Cài đặt',
                            style: TextStyle(
                              color: AppColors.white,
                              fontSize: 18,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Column(
                        children: [
                          SettingsMenuItem(
                            icon: Icons.home,
                            title: 'Bảng điều khiển',
                            iconColor: Colors.blue,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const DashboardScreen(),
                                ),
                              );
                            },
                          ),
                          SettingsMenuItem(
                            icon: Icons.history,
                            title: 'Biên lai',
                            iconColor: Colors.green,
                            onTap: () {
                              Navigator.pop(context);
                            },
                          ),
                          SettingsMenuItem(
                            icon: Icons.receipt,
                            title: 'Hóa đơn',
                            iconColor: Colors.orange,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const InvoiceScreen(),
                                ),
                              );
                            },
                          ),
                          SettingsMenuItem(
                            icon: Icons.list,
                            title: 'Bảng báo giá',
                            iconColor: Colors.purple,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const QuotationScreen(),
                                ),
                              );
                            },
                          ),
                          SettingsMenuItem(
                            icon: Icons.shopping_cart,
                            title: 'Đơn đặt hàng',
                            iconColor: Colors.red,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const OrderScreen(),
                                ),
                              );
                            },
                          ),
                          SettingsMenuItem(
                            icon: Icons.person,
                            title: 'Khách hàng',
                            iconColor: Colors.teal,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const CustomerScreen(),
                                ),
                              );
                            },
                          ),

                          SettingsMenuItem(
                            icon: Icons.inventory,
                            title: 'Mặt hàng/Dịch vụ',
                            showChevron: true,
                            iconColor: Colors.indigo,
                            onTap: () {
                              setState(() {
                                _isProductExpanded = !_isProductExpanded;
                              });
                            },
                          ),
                          if (_isProductExpanded) ...[
                            // Mục con - Mặt hàng
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: SettingsMenuItem(
                                icon: Icons.shopping_bag,
                                title: 'Mặt hàng',
                                iconColor: Colors.purple,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const ProductScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Mục con - Dịch vụ
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: SettingsMenuItem(
                                icon: Icons.miscellaneous_services,
                                title: 'Dịch vụ',
                                iconColor: Colors.blueGrey,
                                onTap: () {
                                  Navigator.pop(context);
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder:
                                          (context) => const ServiceScreen(),
                                    ),
                                  );
                                },
                              ),
                            ),
                            // Mục con - Danh mục
                            Padding(
                              padding: EdgeInsets.only(left: 30.0),
                              child: SettingsMenuItem(
                                icon: Icons.category,
                                title: 'Danh mục',
                                iconColor: Colors.amber,
                                onTap: () {
                                  Navigator.pop(context);
                                  // Xử lý khi chọn Danh mục
                                },
                              ),
                            ),
                          ],

                          SettingsMenuItem(
                            icon: Icons.attach_money,
                            title: 'Chi phí.',
                            iconColor: Colors.amber,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ExpenseScreen(),
                                ),
                              );
                            },
                          ),
                          SettingsMenuItem(
                            icon: Icons.credit_card,
                            title: 'Thanh toán',
                            iconColor: Colors.deepOrange,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const PaymentScreen(),
                                ),
                              );
                            },
                          ),
                          SettingsMenuItem(
                            icon: Icons.bar_chart,
                            title: 'Báo cáo, xuất khẩu',
                            iconColor: Colors.brown,
                            onTap: () {
                              Navigator.pop(context);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const ReportScreen(),
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Icon(
                      Icons.receipt_outlined,
                      size: 64.0,
                      color: const Color(0xFFa8c7fa),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Positioned(
            bottom: ResponsiveHelper.getAdaptiveValue(
              context: context,
              desktop: 24.0,
              mobile: 16.0,
            ),
            right: ResponsiveHelper.getAdaptiveValue(
              context: context,
              desktop: 24.0,
              mobile: 16.0,
            ),
            child: Container(
              width: ResponsiveHelper.getAdaptiveValue(
                context: context,
                desktop: 56.0,
                mobile: 48.0,
              ),
              height: ResponsiveHelper.getAdaptiveValue(
                context: context,
                desktop: 56.0,
                mobile: 48.0,
              ),
              decoration: BoxDecoration(
                color: const Color(0xFF00c853),
                borderRadius: BorderRadius.circular(28.0),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withAlpha(51),
                    blurRadius: 5.0,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  borderRadius: BorderRadius.circular(28.0),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const CreateReceiptScreen(),
                      ),
                    );
                  },
                  child: Center(
                    child: Icon(
                      Icons.add,
                      color: Colors.white,
                      size: ResponsiveHelper.getAdaptiveValue(
                        context: context,
                        desktop: 24.0,
                        mobile: 20.0,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
