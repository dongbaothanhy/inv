import 'package:flutter/material.dart';
import '../theme/colors.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Bảng điều khiển',
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
      body: Column(
        children: [
          // Phần chọn tháng
          Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.chevron_left,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    // Xử lý khi nhấn nút tháng trước
                  },
                ),
                const Text(
                  'Tháng ba 2025',
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.chevron_right,
                    color: AppColors.primary,
                  ),
                  onPressed: () {
                    // Xử lý khi nhấn nút tháng sau
                  },
                ),
              ],
            ),
          ),

          // Danh sách các mục thống kê
          Expanded(
            child: ListView(
              children: [
                // Biên lai
                _buildExpandableItem(
                  title: 'Biên lai',
                  count: '0',
                  details: [
                    _buildDetailRow('Đã thanh toán', '0', Colors.green),
                    _buildDetailRow('Chưa thanh toán', '0', Colors.orange),
                  ],
                ),

                // Hóa đơn
                _buildExpandableItem(
                  title: 'Hóa đơn',
                  count: '0',
                  details: [
                    _buildDetailRow('Đã thanh toán', '0', Colors.green),
                    _buildDetailRow('Chưa thanh toán', '0', Colors.orange),
                  ],
                ),

                // Bảng báo giá
                _buildSimpleItem('Bảng báo giá', '0'),

                // Đơn đặt hàng
                _buildSimpleItem('Đơn đặt hàng', '0'),

                // Thanh toán
                _buildSimpleItem('Thanh toán', '0', textColor: Colors.green),

                // Chi phí
                _buildSimpleItem('Chi phí.', '0', textColor: Colors.orange),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildExpandableItem({
    required String title,
    required String count,
    required List<Widget> details,
  }) {
    return Column(children: [_buildSimpleItem(title, count), ...details]);
  }

  Widget _buildSimpleItem(String title, String count, {Color? textColor}) {
    return Container(
      decoration: const BoxDecoration(
        border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
      ),
      child: ListTile(
        title: Text(title, style: TextStyle(color: textColor, fontSize: 16)),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text('$count đ', style: TextStyle(color: textColor, fontSize: 16)),
            const Icon(Icons.chevron_right, color: Colors.black26),
          ],
        ),
      ),
    );
  }

  Widget _buildDetailRow(String title, String count, Color color) {
    return Padding(
      padding: const EdgeInsets.only(left: 16.0),
      child: Container(
        decoration: const BoxDecoration(
          border: Border(bottom: BorderSide(color: Colors.black12, width: 0.5)),
        ),
        child: ListTile(
          title: Text(title, style: TextStyle(color: color, fontSize: 14)),
          trailing: Text(
            '$count đ',
            style: TextStyle(color: color, fontSize: 14),
          ),
        ),
      ),
    );
  }
}
