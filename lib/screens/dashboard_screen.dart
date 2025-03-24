import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/shared_drawer.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  // Dữ liệu giả lập cho bảng điều khiển
  final Map<String, dynamic> _dashboardData = {
    'revenue': {
      'today': 2500000,
      'week': 15700000,
      'month': 67500000,
      'previous_month': 55000000,
    },
    'orders': {'total': 246, 'pending': 12, 'completed': 234},
    'customers': {'total': 178, 'new_this_month': 15},
    'inventory': {'low_stock': 7, 'out_of_stock': 3},
    'recent_transactions': [
      {
        'id': 'HD001',
        'type': 'Hóa đơn',
        'customer': 'Nguyễn Văn A',
        'amount': 2500000,
        'date': '15/07/2023',
      },
      {
        'id': 'BL003',
        'type': 'Biên lai',
        'customer': 'Trần Thị B',
        'amount': 1200000,
        'date': '28/07/2023',
      },
      {
        'id': 'HD008',
        'type': 'Hóa đơn',
        'customer': 'Lê Văn C',
        'amount': 3700000,
        'date': '05/08/2023',
      },
      {
        'id': 'CP045',
        'type': 'Chi phí',
        'customer': 'Tiền thuê',
        'amount': -5000000,
        'date': '01/08/2023',
      },
    ],
  };

  // Dữ liệu giả định cho biểu đồ
  final List<Map<String, dynamic>> _chartData = [
    {'month': 'T1', 'value': 15},
    {'month': 'T2', 'value': 22},
    {'month': 'T3', 'value': 18},
    {'month': 'T4', 'value': 25},
    {'month': 'T5', 'value': 30},
    {'month': 'T6', 'value': 28},
    {'month': 'T7', 'value': 32},
    {'month': 'T8', 'value': 35},
  ];

  String _selectedPeriod = 'Tháng này';
  final List<String> _periods = [
    'Hôm nay',
    'Tuần này',
    'Tháng này',
    'Quý này',
    'Năm nay',
  ];

  @override
  Widget build(BuildContext context) {
    // Tính toán phần trăm tăng trưởng
    final double growthRate =
        (_dashboardData['revenue']['month'] -
            _dashboardData['revenue']['previous_month']) /
        _dashboardData['revenue']['previous_month'] *
        100;

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Bảng điều khiển',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {
              _showPeriodPicker(context);
            },
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.white),
            onPressed: () {
              // Làm mới dữ liệu
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Đã làm mới dữ liệu'),
                  duration: Duration(seconds: 1),
                ),
              );
            },
          ),
        ],
      ),
      drawer: const SharedDrawer(
        currentIndex: 0,
      ), // Giả sử Dashboard có index 0
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Thời gian được chọn
            Container(
              padding: const EdgeInsets.all(16),
              color: AppColors.primary.withAlpha(26),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Thời gian: $_selectedPeriod',
                    style: const TextStyle(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                    ),
                  ),
                  TextButton.icon(
                    icon: const Icon(Icons.date_range, size: 18),
                    label: const Text('Thay đổi'),
                    onPressed: () {
                      _showPeriodPicker(context);
                    },
                  ),
                ],
              ),
            ),

            // Các chỉ số tổng quan
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Tổng quan chỉ số
                  const Text(
                    'Tổng quan kinh doanh',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),

                  // Card doanh thu
                  _buildMetricCard(
                    title: 'Doanh thu',
                    value: _formatCurrency(_dashboardData['revenue']['month']),
                    icon: Icons.attach_money,
                    color: Colors.green,
                    change:
                        '${growthRate >= 0 ? '+' : ''}${growthRate.toStringAsFixed(1)}%',
                    isPositive: growthRate >= 0,
                  ),

                  // Row với 2 card: đơn hàng và khách hàng
                  Row(
                    children: [
                      Expanded(
                        child: _buildMetricCard(
                          title: 'Đơn hàng',
                          value: _dashboardData['orders']['total'].toString(),
                          icon: Icons.shopping_cart,
                          color: Colors.orange,
                          change:
                              '+${_dashboardData['orders']['pending']} chờ xử lý',
                          isPositive: true,
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: _buildMetricCard(
                          title: 'Khách hàng',
                          value:
                              _dashboardData['customers']['total'].toString(),
                          icon: Icons.people,
                          color: Colors.blue,
                          change:
                              '+${_dashboardData['customers']['new_this_month']} mới',
                          isPositive: true,
                        ),
                      ),
                    ],
                  ),

                  // Biểu đồ doanh thu
                  const SizedBox(height: 24),
                  const Text(
                    'Doanh thu theo thời gian',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  Container(
                    height: 200,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(16),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withAlpha(26),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: const Offset(0, 3),
                        ),
                      ],
                    ),
                    padding: const EdgeInsets.all(16),
                    child: _buildSimpleChart(),
                  ),

                  // Các giao dịch gần đây
                  const SizedBox(height: 24),
                  const Text(
                    'Giao dịch gần đây',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  ..._dashboardData['recent_transactions'].map((transaction) {
                    return _buildTransactionItem(transaction);
                  }).toList(),

                  // Cảnh báo tồn kho
                  if (_dashboardData['inventory']['low_stock'] > 0 ||
                      _dashboardData['inventory']['out_of_stock'] > 0)
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(height: 24),
                        const Text(
                          'Cảnh báo tồn kho',
                          style: TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Card(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(16.0),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.warning_amber_rounded,
                                      color: Colors.orange,
                                      size: 28,
                                    ),
                                    const SizedBox(width: 12),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            '${_dashboardData['inventory']['low_stock']} sản phẩm sắp hết hàng',
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 16,
                                            ),
                                          ),
                                          const SizedBox(height: 4),
                                          Text(
                                            '${_dashboardData['inventory']['out_of_stock']} sản phẩm đã hết hàng',
                                            style: TextStyle(
                                              color: Colors.grey[700],
                                              fontSize: 14,
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),
                                    TextButton(
                                      onPressed: () {
                                        // Điều hướng đến màn hình quản lý kho
                                      },
                                      child: const Text('Xem chi tiết'),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _showPeriodPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        return SafeArea(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text(
                  'Chọn khoảng thời gian',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              const Divider(),
              Expanded(
                child: ListView.builder(
                  itemCount: _periods.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final period = _periods[index];
                    return ListTile(
                      title: Text(period),
                      trailing:
                          period == _selectedPeriod
                              ? const Icon(
                                Icons.check,
                                color: AppColors.primary,
                              )
                              : null,
                      onTap: () {
                        setState(() {
                          _selectedPeriod = period;
                        });
                        Navigator.pop(context);
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMetricCard({
    required String title,
    required String value,
    required IconData icon,
    required Color color,
    required String change,
    required bool isPositive,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.grey.withAlpha(26),
            spreadRadius: 2,
            blurRadius: 5,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              ),
              Icon(icon, color: color.withAlpha(179), size: 24),
            ],
          ),
          const SizedBox(height: 12),
          Text(
            value,
            style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 8),
          Row(
            children: [
              Icon(
                isPositive ? Icons.arrow_upward : Icons.arrow_downward,
                color: isPositive ? Colors.green : Colors.red,
                size: 16,
              ),
              const SizedBox(width: 4),
              Text(
                change,
                style: TextStyle(
                  color: isPositive ? Colors.green : Colors.red,
                  fontSize: 14,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildTransactionItem(Map<String, dynamic> transaction) {
    final bool isPositive = transaction['amount'] >= 0;

    return Card(
      margin: const EdgeInsets.only(bottom: 10),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: _getTransactionColor(
            transaction['type'],
          ).withAlpha(26),
          child: Icon(
            _getTransactionIcon(transaction['type']),
            color: _getTransactionColor(transaction['type']),
            size: 20,
          ),
        ),
        title: Text(
          '${transaction['type']} #${transaction['id']}',
          style: const TextStyle(fontWeight: FontWeight.w500),
        ),
        subtitle: Text(
          '${transaction['customer']} - ${transaction['date']}',
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
        trailing: Text(
          _formatCurrency(transaction['amount']),
          style: TextStyle(
            color: isPositive ? Colors.green : Colors.red,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildSimpleChart() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children:
          _chartData.map((data) {
            return Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  width: 30,
                  height: data['value'] * 4.0, // Chiều cao tỷ lệ với giá trị
                  decoration: BoxDecoration(
                    color: AppColors.primary.withAlpha(179),
                    borderRadius: const BorderRadius.vertical(
                      top: Radius.circular(6),
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  data['month'],
                  style: TextStyle(color: Colors.grey[600], fontSize: 12),
                ),
              ],
            );
          }).toList(),
    );
  }

  String _formatCurrency(dynamic amount) {
    final num = amount is int ? amount : amount.toInt();
    if (num == 0) return '0 ₫';

    final isNegative = num < 0;
    final absNum = num.abs();

    String result = '';
    String numStr = absNum.toString();

    for (int i = 0; i < numStr.length; i++) {
      if (i > 0 && (numStr.length - i) % 3 == 0) {
        result += '.';
      }
      result += numStr[i];
    }

    return '${isNegative ? '-' : ''}$result ₫';
  }

  Color _getTransactionColor(String type) {
    switch (type) {
      case 'Hóa đơn':
        return Colors.green;
      case 'Biên lai':
        return Colors.blue;
      case 'Chi phí':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }

  IconData _getTransactionIcon(String type) {
    switch (type) {
      case 'Hóa đơn':
        return Icons.receipt;
      case 'Biên lai':
        return Icons.receipt_long;
      case 'Chi phí':
        return Icons.money_off;
      default:
        return Icons.attach_money;
    }
  }
}
