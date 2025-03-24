import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/shared_drawer.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  final List<Map<String, dynamic>> _reports = [
    {
      'title': 'Báo cáo doanh thu',
      'description': 'Tổng quan doanh thu theo thời gian',
      'icon': Icons.bar_chart,
      'color': Colors.blue,
    },
    {
      'title': 'Báo cáo chi phí',
      'description': 'Phân tích chi phí theo danh mục',
      'icon': Icons.money_off,
      'color': Colors.red,
    },
    {
      'title': 'Báo cáo lợi nhuận',
      'description': 'Phân tích lợi nhuận theo thời gian',
      'icon': Icons.trending_up,
      'color': Colors.green,
    },
    {
      'title': 'Báo cáo bán hàng',
      'description': 'Sản phẩm/dịch vụ bán chạy nhất',
      'icon': Icons.shopping_cart,
      'color': Colors.orange,
    },
    {
      'title': 'Báo cáo tồn kho',
      'description': 'Kiểm soát hàng tồn kho',
      'icon': Icons.inventory_2,
      'color': Colors.purple,
    },
    {
      'title': 'Báo cáo công nợ',
      'description': 'Công nợ khách hàng và nhà cung cấp',
      'icon': Icons.account_balance_wallet,
      'color': Colors.teal,
    },
    {
      'title': 'Xuất dữ liệu',
      'description': 'Xuất dữ liệu sang Excel, PDF',
      'icon': Icons.cloud_download,
      'color': Colors.indigo,
    },
  ];

  String _selectedPeriod = 'Tháng này';
  final List<String> _periods = [
    'Hôm nay',
    'Tuần này',
    'Tháng này',
    'Quý này',
    'Năm nay',
    'Tùy chọn',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Báo cáo & Xuất khẩu',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.calendar_today, color: Colors.white),
            onPressed: () {
              _showPeriodPicker(context);
            },
          ),
        ],
      ),
      drawer: const SharedDrawer(
        currentIndex: 10,
      ), // Giả sử index 10 là báo cáo
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Hiển thị period đã chọn
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
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

          // Danh sách báo cáo
          Expanded(
            child: GridView.builder(
              padding: const EdgeInsets.all(16),
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: 1.0,
                crossAxisSpacing: 16,
                mainAxisSpacing: 16,
              ),
              itemCount: _reports.length,
              itemBuilder: (context, index) {
                final report = _reports[index];
                return _buildReportCard(report);
              },
            ),
          ),
        ],
      ),
      // Không cần FAB ở màn hình báo cáo
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
                        if (period == 'Tùy chọn') {
                          _showCustomDatePicker(context);
                        }
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

  Future<void> _showCustomDatePicker(BuildContext context) async {
    // Hiển thị hộp thoại chọn khoảng thời gian tùy chỉnh
    // Ở đây chỉ là giao diện mẫu, có thể mở rộng thêm
    final DateTimeRange? picked = await showDateRangePicker(
      context: context,
      firstDate: DateTime(2020),
      lastDate: DateTime(2025),
      initialDateRange: DateTimeRange(
        start: DateTime.now().subtract(const Duration(days: 7)),
        end: DateTime.now(),
      ),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: AppColors.primary,
              onPrimary: Colors.white,
              onSurface: Colors.black,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      // Format và hiển thị khoảng thời gian đã chọn
      final start =
          "${picked.start.day}/${picked.start.month}/${picked.start.year}";
      final end = "${picked.end.day}/${picked.end.month}/${picked.end.year}";
      setState(() {
        _selectedPeriod = "Từ $start đến $end";
      });
    }
  }

  Widget _buildReportCard(Map<String, dynamic> report) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: InkWell(
        onTap: () {
          // Chuyển đến màn hình báo cáo chi tiết
          // Navigator.push(
          //   context,
          //   MaterialPageRoute(builder: (context) => DetailReportScreen(report['title'])),
          // );
          _showReportNotImplemented(context, report['title']);
        },
        borderRadius: BorderRadius.circular(16),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(report['icon'], size: 40, color: report['color']),
              const SizedBox(height: 16),
              Text(
                report['title'],
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 8),
              Text(
                report['description'],
                style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                textAlign: TextAlign.center,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showReportNotImplemented(BuildContext context, String reportName) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text('$reportName sẽ được cập nhật'),
            content: const Text(
              'Chức năng này đang được phát triển và sẽ có trong phiên bản tới.',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Đóng'),
              ),
            ],
          ),
    );
  }
}
