import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import 'create_quotation_screen.dart';
import '../widgets/shared_drawer.dart';

class QuotationScreen extends StatefulWidget {
  const QuotationScreen({super.key});

  @override
  State<QuotationScreen> createState() => _QuotationScreenState();
}

class _QuotationScreenState extends State<QuotationScreen> {
  // Xóa biến không sử dụng
  // bool _isProductExpanded = false;
  // int _selectedIndex = 1;

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
            'Bảng báo giá',
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
      drawer: SharedDrawer(currentIndex: 1),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Icon(
                      Icons.list_alt,
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
                        builder: (context) => const CreateQuotationScreen(),
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

  // Xóa phương thức _onMenuItemTap vì không sử dụng nữa
  // Tất cả logic điều hướng đã được chuyển sang component SharedDrawer
}
