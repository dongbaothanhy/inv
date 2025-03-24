import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../screens/dashboard_screen.dart';
import '../screens/quotation_screen.dart';
import '../screens/order_screen.dart';
import '../main.dart' hide InvoiceScreen;
import '../screens/invoice_screen.dart';
import '../screens/customer_screen.dart';
import '../screens/product_screen.dart';
import '../screens/service_screen.dart';
import '../screens/expense_screen.dart';
import '../screens/payment_screen.dart';
import '../screens/report_screen.dart';
import '../screens/settings_screen.dart';
import '../widgets/settings_menu_item.dart';
import '../screens/category_screen.dart';
// Import các màn hình khác

class SharedDrawer extends StatefulWidget {
  final int currentIndex;

  const SharedDrawer({super.key, required this.currentIndex});

  @override
  State<SharedDrawer> createState() => _SharedDrawerState();
}

class _SharedDrawerState extends State<SharedDrawer> {
  bool _isProductExpanded = false;

  @override
  Widget build(BuildContext context) {
    return Drawer(
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
                          isSelected: widget.currentIndex == 0,
                          onTap: () => _onMenuItemTap(context, 0),
                        ),
                        SettingsMenuItem(
                          icon: Icons.history,
                          title: 'Biên lai',
                          iconColor: Colors.green,
                          isSelected: widget.currentIndex == 3,
                          onTap: () => _onMenuItemTap(context, 3),
                        ),
                        SettingsMenuItem(
                          icon: Icons.receipt,
                          title: 'Hóa đơn',
                          iconColor: Colors.orange,
                          isSelected: widget.currentIndex == 4,
                          onTap: () => _onMenuItemTap(context, 4),
                        ),
                        SettingsMenuItem(
                          icon: Icons.list,
                          title: 'Bảng báo giá',
                          iconColor: Colors.purple,
                          isSelected: widget.currentIndex == 1,
                          onTap: () => _onMenuItemTap(context, 1),
                        ),
                        SettingsMenuItem(
                          icon: Icons.shopping_cart,
                          title: 'Đơn đặt hàng',
                          iconColor: Colors.red,
                          isSelected: widget.currentIndex == 2,
                          onTap: () => _onMenuItemTap(context, 2),
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
                                    builder: (context) => const ProductScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
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
                                    builder: (context) => const ServiceScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(left: 30.0),
                            child: SettingsMenuItem(
                              icon: Icons.category,
                              title: 'Danh mục',
                              iconColor: Colors.amber,
                              onTap: () {
                                Navigator.pop(context);
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder:
                                        (context) => const CategoryScreen(),
                                  ),
                                );
                              },
                            ),
                          ),
                        ],
                        SettingsMenuItem(
                          icon: Icons.attach_money,
                          title: 'Chi phí',
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
    );
  }

  void _onMenuItemTap(BuildContext context, int index) {
    // Đóng drawer
    Navigator.pop(context);

    // Nếu đang ở màn hình này rồi, không làm gì cả
    if (widget.currentIndex == index) {
      return;
    }

    // Chọn màn hình phù hợp
    Widget screen;
    switch (index) {
      case 0:
        screen = DashboardScreen();
        break;
      case 1:
        screen = QuotationScreen();
        break;
      case 2:
        screen = OrderScreen();
        break;
      case 3:
        screen = const ReceiptScreen();
        break;
      case 4:
        screen = const InvoiceScreen();
        break;
      default:
        screen = DashboardScreen();
    }

    // Điều hướng với pushAndRemoveUntil
    Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(builder: (context) => screen),
      (route) => false,
    );
  }
}
