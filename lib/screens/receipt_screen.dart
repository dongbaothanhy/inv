import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/shared_drawer.dart';
import 'create_receipt_screen.dart'; // Giả sử sẽ tạo màn hình này sau
import 'package:intl/intl.dart';

class ReceiptScreen extends StatefulWidget {
  const ReceiptScreen({super.key});

  @override
  State<ReceiptScreen> createState() => _ReceiptScreenState();
}

class _ReceiptScreenState extends State<ReceiptScreen> {
  final _searchController = TextEditingController();
  String _selectedFilter = 'Tất cả';
  final List<String> _filters = ['Tất cả', 'Hôm nay', 'Tuần này', 'Tháng này'];

  // Dữ liệu giả lập cho danh sách biên lai
  final List<Map<String, dynamic>> _receipts = [
    {
      'id': 'BL001',
      'customerName': 'Nguyễn Văn A',
      'date': '15/07/2023',
      'total': 2500000,
      'status': 'Đã thanh toán',
      'items': 3,
    },
    {
      'id': 'BL002',
      'customerName': 'Công ty TNHH XYZ',
      'date': '22/07/2023',
      'total': 5600000,
      'status': 'Đã thanh toán',
      'items': 5,
    },
    {
      'id': 'BL003',
      'customerName': 'Trần Thị B',
      'date': '28/07/2023',
      'total': 1200000,
      'status': 'Chưa thanh toán',
      'items': 2,
    },
    {
      'id': 'BL004',
      'customerName': 'Lê Văn C',
      'date': '05/08/2023',
      'total': 3700000,
      'status': 'Đã thanh toán',
      'items': 4,
    },
    {
      'id': 'BL005',
      'customerName': 'Phạm Thị D',
      'date': '12/08/2023',
      'total': 950000,
      'status': 'Chưa thanh toán',
      'items': 1,
    },
  ];

  List<Map<String, dynamic>> get _filteredReceipts {
    if (_searchController.text.isNotEmpty) {
      String query = _searchController.text.toLowerCase();
      return _receipts.where((receipt) {
        return receipt['id'].toLowerCase().contains(query) ||
            receipt['customerName'].toLowerCase().contains(query);
      }).toList();
    }

    // Áp dụng bộ lọc theo thời gian (giả lập)
    if (_selectedFilter != 'Tất cả') {
      return _receipts; // Trong ứng dụng thực tế, cần lọc theo thời gian
    }

    return _receipts;
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Biên lai',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.filter_list, color: Colors.white),
            onPressed: () {
              _showFilterOptions(context);
            },
          ),
        ],
      ),
      drawer: const SharedDrawer(currentIndex: 3), // Giả sử biên lai có index 3
      body: Column(
        children: [
          // Thanh tìm kiếm
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: TextField(
              controller: _searchController,
              decoration: InputDecoration(
                hintText: 'Tìm kiếm biên lai...',
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                  borderSide: BorderSide(color: Colors.grey[300]!),
                ),
                contentPadding: const EdgeInsets.symmetric(vertical: 0),
                filled: true,
                fillColor: Colors.white,
              ),
              onChanged: (value) {
                setState(() {});
              },
            ),
          ),

          // Hiển thị bộ lọc đã chọn
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Row(
              children: [
                const Text(
                  'Bộ lọc: ',
                  style: TextStyle(fontWeight: FontWeight.w500),
                ),
                Chip(
                  label: Text(_selectedFilter),
                  deleteIcon: const Icon(Icons.close, size: 18),
                  onDeleted:
                      _selectedFilter != 'Tất cả'
                          ? () {
                            setState(() {
                              _selectedFilter = 'Tất cả';
                            });
                          }
                          : null,
                  backgroundColor: AppColors.primary.withAlpha(26),
                  labelStyle: const TextStyle(
                    color: AppColors.primary,
                    fontSize: 13,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 8),

          // Danh sách biên lai
          Expanded(
            child:
                _filteredReceipts.isEmpty
                    ? _buildEmptyState()
                    : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      itemCount: _filteredReceipts.length,
                      itemBuilder: (context, index) {
                        final receipt = _filteredReceipts[index];
                        return _buildReceiptItem(receipt);
                      },
                    ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.fabGreen,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const CreateReceiptScreen(),
            ),
          );
        },
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.receipt_long_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Không tìm thấy biên lai nào',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Thử thay đổi bộ lọc hoặc thêm biên lai mới',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildReceiptItem(Map<String, dynamic> receipt) {
    final isCompleted = receipt['status'] == 'Đã thanh toán';
    final formatter = NumberFormat.currency(locale: 'vi_VN', symbol: '₫');

    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: () {
          // Mở màn hình chi tiết biên lai
        },
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Mã biên lai: ${receipt['id']}',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 8,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color:
                          isCompleted
                              ? Colors.green.withAlpha(26)
                              : Colors.orange.withAlpha(26),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      receipt['status'],
                      style: TextStyle(
                        color: isCompleted ? Colors.green : Colors.orange,
                        fontSize: 12,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                'Khách hàng: ${receipt['customerName']}',
                style: const TextStyle(fontSize: 14),
              ),
              const SizedBox(height: 4),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Ngày: ${receipt['date']}',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                  Text(
                    '${receipt['items']} sản phẩm',
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),
                ],
              ),
              const Divider(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Text('Tổng tiền:', style: TextStyle(fontSize: 15)),
                  Text(
                    formatter.format(receipt['total']),
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                      color: AppColors.primary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _showFilterOptions(BuildContext context) {
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
                  itemCount: _filters.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    final filter = _filters[index];
                    return ListTile(
                      title: Text(filter),
                      trailing:
                          filter == _selectedFilter
                              ? const Icon(
                                Icons.check,
                                color: AppColors.primary,
                              )
                              : null,
                      onTap: () {
                        setState(() {
                          _selectedFilter = filter;
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
}
