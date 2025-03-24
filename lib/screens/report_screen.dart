import 'package:flutter/material.dart';
import '../utils/responsive_helper.dart';
import '../theme/colors.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

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
            'Báo cáo',
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
        ),
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
                const Text(
                  'Lựa chọn',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 16.0),
                // Dropdown chọn loại báo cáo
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: 'Biên lai',
                      items: const [
                        DropdownMenuItem(
                          value: 'Biên lai',
                          child: Text('Biên lai'),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 24.0),
                // Chọn ngày bắt đầu
                const Text(
                  'Ngày bắt đầu',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: TextField(
                    controller: TextEditingController(text: '23/02/2025'),
                    decoration: const InputDecoration(border: InputBorder.none),
                    readOnly: true,
                    onTap: () {
                      // Hiển thị date picker
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                // Chọn ngày kết thúc
                const Text(
                  'Ngày cuối',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: TextField(
                    controller: TextEditingController(text: '23/03/2025'),
                    decoration: const InputDecoration(border: InputBorder.none),
                    readOnly: true,
                    onTap: () {
                      // Hiển thị date picker
                    },
                  ),
                ),
                const SizedBox(height: 24.0),
                // Dropdown chọn trạng thái
                const Text(
                  'Status',
                  style: TextStyle(fontSize: 16.0, fontWeight: FontWeight.w500),
                ),
                const SizedBox(height: 8.0),
                Container(
                  decoration: BoxDecoration(
                    border: Border(
                      bottom: BorderSide(color: Colors.grey[300]!),
                    ),
                  ),
                  child: DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      value: 'Tất cả',
                      items: const [
                        DropdownMenuItem(
                          value: 'Tất cả',
                          child: Text('Tất cả'),
                        ),
                      ],
                      onChanged: (value) {},
                    ),
                  ),
                ),
                const SizedBox(height: 32.0),
                // Nút tạo báo cáo
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.fabGreen,
                      padding: const EdgeInsets.symmetric(vertical: 16.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                    onPressed: () {
                      // Xử lý khi nhấn nút tạo báo cáo
                    },
                    child: const Text(
                      'TẠO BÁO CÁO',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 16.0,
                        fontWeight: FontWeight.w500,
                      ),
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
}
