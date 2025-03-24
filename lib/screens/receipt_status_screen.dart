import 'package:flutter/material.dart';
import '../theme/colors.dart';

class ReceiptStatusScreen extends StatefulWidget {
  const ReceiptStatusScreen({super.key});

  @override
  State<ReceiptStatusScreen> createState() => _ReceiptStatusScreenState();
}

class _ReceiptStatusScreenState extends State<ReceiptStatusScreen> {
  String _selectedStatus = 'Không hiển thị';

  // Danh sách các trạng thái có thể chọn
  final List<String> _statusList = [
    'Không hiển thị',
    'Đã thanh toán',
    'Mở',
    'Gởi',
    'Đã kết thúc',
    'Đang chờ xử lý.',
    'Hủy bỏ',
  ];

  final TextEditingController _prefixController = TextEditingController(
    text: '000',
  );
  final TextEditingController _numberController = TextEditingController(
    text: '1',
  );
  final TextEditingController _dateController = TextEditingController(
    text: '24/03/2025',
  );

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
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: () {
              // Xử lý lưu thông tin
              Navigator.pop(context);
            },
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Card(
          elevation: 2,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tiếp đầu ngữ
                const Text('Tiếp đầu n...', style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _prefixController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                ),
                const SizedBox(height: 24.0),

                // Con số
                const Text('Con số', style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _numberController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  keyboardType: TextInputType.number,
                ),
                const SizedBox(height: 24.0),

                // Ngày
                const Text('Ngày', style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _dateController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                  ),
                  readOnly: true,
                  onTap: () async {
                    final DateTime? picked = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime(2000),
                      lastDate: DateTime(2100),
                    );
                    if (picked != null) {
                      setState(() {
                        _dateController.text =
                            "${picked.day}/${picked.month}/${picked.year}";
                      });
                    }
                  },
                ),
                const SizedBox(height: 24.0),

                // Trạng thái
                const Text('Trạng thái', style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      value: _selectedStatus,
                      isExpanded: true,
                      items:
                          _statusList.map((String status) {
                            return DropdownMenuItem<String>(
                              value: status,
                              child: Text(status),
                            );
                          }).toList(),
                      onChanged: (String? newValue) {
                        if (newValue != null) {
                          setState(() {
                            _selectedStatus = newValue;
                          });
                        }
                      },
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _prefixController.dispose();
    _numberController.dispose();
    _dateController.dispose();
    super.dispose();
  }
}
