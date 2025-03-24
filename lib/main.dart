import 'package:flutter/material.dart';
import 'screens/create_receipt_screen.dart';
import 'utils/responsive_helper.dart';
import 'screens/create_invoice_screen.dart';
import 'widgets/shared_drawer.dart';

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
      drawer: SharedDrawer(currentIndex: 3),
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

// Thêm lớp mới cho màn hình Hóa đơn
class InvoiceScreen extends StatefulWidget {
  const InvoiceScreen({super.key});

  @override
  State<InvoiceScreen> createState() => _InvoiceScreenState();
}

class _InvoiceScreenState extends State<InvoiceScreen> {
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
      drawer: SharedDrawer(currentIndex: 4),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 100.0),
                    child: Icon(
                      Icons.receipt_long_outlined,
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
    );
  }
}
