import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import '../theme/colors.dart';
import '../widgets/shared_drawer.dart';
import 'create_invoice_screen.dart';

class InvoiceScreen extends StatelessWidget {
  const InvoiceScreen({super.key});

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
          backgroundColor: AppColors.primary,
          title: Text(
            'Hóa đơn',
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
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Icon(
                      Icons.description_outlined, // Icon khác với Biên lai
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
                color: AppColors.fabGreen,
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
                        builder: (context) => const CreateInvoiceScreen(),
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
      drawer: SharedDrawer(currentIndex: 4),
    );
  }
}
