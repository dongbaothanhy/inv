import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'receipt_status_screen.dart';
import 'add_customer_screen.dart';
import 'add_discount_screen.dart';

class CreateReceiptScreen extends StatelessWidget {
  const CreateReceiptScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('Biên lai', style: TextStyle(color: Colors.white)),
        actions: [
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {
              // Hiển thị menu
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Header xanh lá
          Container(
            padding: const EdgeInsets.all(16.0),
            color: AppColors.fabGreen,
            child: Row(
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      '0001',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    SizedBox(height: 4),
                    Text('Trạng thái:', style: TextStyle(color: Colors.white)),
                  ],
                ),
                const Spacer(),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    const Text(
                      '24/03/2025',
                      style: TextStyle(color: Colors.white),
                    ),
                    IconButton(
                      icon: const Icon(Icons.add, color: Colors.white),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const ReceiptStatusScreen(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ],
            ),
          ),
          // Body
          Expanded(
            child: ListView(
              children: [
                _buildAddItem('Thêm khách hàng', context: context),
                _buildAmountItem('Mặt hàng', '0'),
                _buildAmountItem('Dịch vụ', '0'),
                _buildAmountItem('Chi phí.', '0'),
                _buildTotalItem('Tổng số phụ', '0'),
                _buildAddItem('Thêm giảm giá', context: context),
                _buildAddItem('Thêm thuế'),
                _buildAddItem('Thêm vận chuyển'),
                _buildAddItem('Chi tiết thanh toán/GHI CHÚ'),
                Container(
                  color: AppColors.fabGreen,
                  child: _buildAddItem(
                    'Chữ ký của khách hàng',
                    textColor: Colors.white,
                  ),
                ),
                _buildAddItem('Thêm các trường'),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildAddItem(
    String title, {
    Color? textColor,
    BuildContext? context,
  }) {
    return ListTile(
      title: Text(title, style: TextStyle(color: textColor)),
      trailing: Container(
        width: 24,
        height: 24,
        decoration: BoxDecoration(
          color: AppColors.fabGreen,
          shape: BoxShape.circle,
        ),
        child: const Icon(Icons.add, color: Colors.white, size: 20),
      ),
      onTap: () {
        if (title == 'Thêm khách hàng') {
          Navigator.push(
            context!,
            MaterialPageRoute(builder: (context) => const AddCustomerScreen()),
          );
        } else if (title == 'Thêm giảm giá') {
          Navigator.push(
            context!,
            MaterialPageRoute(builder: (context) => const AddDiscountScreen()),
          );
        }
        // Xử lý các trường hợp khác khi cần
      },
    );
  }

  Widget _buildAmountItem(String title, String amount) {
    return ListTile(
      title: Text(title),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [Text('$amount đ'), const Icon(Icons.keyboard_arrow_down)],
      ),
      onTap: () {
        // Xử lý khi nhấn vào item
      },
    );
  }

  Widget _buildTotalItem(String title, String amount) {
    return Container(
      color: Colors.grey[300],
      child: ListTile(title: Text(title), trailing: Text('$amount đ')),
    );
  }
}
