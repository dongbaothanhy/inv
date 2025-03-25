import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../widgets/shared_drawer.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen> {
  // Các giá trị mặc định cho cài đặt
  String _currency = 'VND';
  String _defaultTax = '10';
  String _paymentTerm = '30';
  String _language = 'Tiếng Việt';
  String _theme = 'Sáng';
  String _fontSize = 'Trung bình';
  String _defaultPaymentMethod = 'Chuyển khoản';

  // Danh sách tùy chọn
  final List<String> _currencies = ['VND', 'USD', 'EUR', 'JPY'];
  final List<String> _paymentTerms = ['7', '15', '30', '45', '60'];
  final List<String> _languages = ['Tiếng Việt', 'English'];
  final List<String> _themes = ['Sáng', 'Tối', 'Hệ thống'];
  final List<String> _fontSizes = ['Nhỏ', 'Trung bình', 'Lớn'];
  final List<String> _paymentMethods = [
    'Tiền mặt',
    'Chuyển khoản',
    'Thẻ tín dụng',
    'Ví điện tử',
    'Khác',
  ];

  // Thông tin doanh nghiệp
  final TextEditingController _companyNameController = TextEditingController(
    text: 'Công ty TNHH Phần mềm XYZ',
  );
  final TextEditingController _addressController = TextEditingController(
    text: '123 Đường Lê Lợi, Quận 1, TP.HCM',
  );
  final TextEditingController _phoneController = TextEditingController(
    text: '028 1234 5678',
  );
  final TextEditingController _emailController = TextEditingController(
    text: 'contact@xyz.com',
  );
  final TextEditingController _taxIdController = TextEditingController(
    text: '0123456789',
  );

  @override
  void dispose() {
    _companyNameController.dispose();
    _addressController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _taxIdController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Cài đặt',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.save, color: Colors.white),
            onPressed: _saveSettings,
          ),
        ],
      ),
      drawer: const SharedDrawer(
        currentIndex: -1,
      ), // Không chọn mục nào trong drawer
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // THÔNG TIN DOANH NGHIỆP
            _buildSectionCard(
              title: 'Thông tin doanh nghiệp',
              icon: Icons.business,
              children: [
                _buildTextField(
                  label: 'Tên doanh nghiệp',
                  controller: _companyNameController,
                  icon: Icons.business_center,
                ),
                _buildTextField(
                  label: 'Địa chỉ',
                  controller: _addressController,
                  icon: Icons.location_on,
                ),
                _buildTextField(
                  label: 'Số điện thoại',
                  controller: _phoneController,
                  icon: Icons.phone,
                ),
                _buildTextField(
                  label: 'Email',
                  controller: _emailController,
                  icon: Icons.email,
                ),
                _buildTextField(
                  label: 'Mã số thuế',
                  controller: _taxIdController,
                  icon: Icons.confirmation_number,
                ),
                const SizedBox(height: 8),
                OutlinedButton.icon(
                  onPressed: () {
                    // Xử lý tải lên logo
                  },
                  icon: const Icon(Icons.upload),
                  label: const Text('Tải lên logo doanh nghiệp'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                  ),
                ),
              ],
            ),

            const SizedBox(height: 16),

            // PHƯƠNG THỨC THANH TOÁN
            _buildSectionCard(
              title: 'Phương thức thanh toán',
              icon: Icons.payment,
              children: [
                ListTile(
                  title: const Text('Phương thức mặc định'),
                  subtitle: Text(_defaultPaymentMethod),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showSelectionDialog(
                      title: 'Chọn phương thức mặc định',
                      options: _paymentMethods,
                      selectedOption: _defaultPaymentMethod,
                      onSelected: (value) {
                        setState(() {
                          _defaultPaymentMethod = value;
                        });
                      },
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Quản lý tài khoản ngân hàng'),
                  subtitle: const Text('3 tài khoản'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showManageBankAccountsDialog();
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Thiết lập mã QR thanh toán'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Hiển thị trang thiết lập mã QR
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // CÀI ĐẶT HÓA ĐƠN
            _buildSectionCard(
              title: 'Cài đặt hóa đơn',
              icon: Icons.receipt_long,
              children: [
                ListTile(
                  title: const Text('Tiền tệ'),
                  subtitle: Text(_currency),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showSelectionDialog(
                      title: 'Chọn tiền tệ',
                      options: _currencies,
                      selectedOption: _currency,
                      onSelected: (value) {
                        setState(() {
                          _currency = value;
                        });
                      },
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Thuế mặc định (%)'),
                  subtitle: Text('$_defaultTax%'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showNumberInputDialog(
                      title: 'Nhập thuế mặc định (%)',
                      initialValue: _defaultTax,
                      onChanged: (value) {
                        setState(() {
                          _defaultTax = value;
                        });
                      },
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Thời hạn thanh toán (ngày)'),
                  subtitle: Text('$_paymentTerm ngày'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showSelectionDialog(
                      title: 'Chọn thời hạn thanh toán',
                      options: _paymentTerms,
                      selectedOption: _paymentTerm,
                      onSelected: (value) {
                        setState(() {
                          _paymentTerm = value;
                        });
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // GIAO DIỆN
            _buildSectionCard(
              title: 'Giao diện',
              icon: Icons.palette,
              children: [
                ListTile(
                  title: const Text('Ngôn ngữ'),
                  subtitle: Text(_language),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showSelectionDialog(
                      title: 'Chọn ngôn ngữ',
                      options: _languages,
                      selectedOption: _language,
                      onSelected: (value) {
                        setState(() {
                          _language = value;
                        });
                      },
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Chủ đề'),
                  subtitle: Text(_theme),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showSelectionDialog(
                      title: 'Chọn chủ đề',
                      options: _themes,
                      selectedOption: _theme,
                      onSelected: (value) {
                        setState(() {
                          _theme = value;
                        });
                      },
                    );
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Kích thước chữ'),
                  subtitle: Text(_fontSize),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    _showSelectionDialog(
                      title: 'Chọn kích thước chữ',
                      options: _fontSizes,
                      selectedOption: _fontSize,
                      onSelected: (value) {
                        setState(() {
                          _fontSize = value;
                        });
                      },
                    );
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // SAO LƯU & KHÔI PHỤC
            _buildSectionCard(
              title: 'Sao lưu & Khôi phục',
              icon: Icons.backup,
              children: [
                ListTile(
                  title: const Text('Sao lưu dữ liệu'),
                  subtitle: const Text('Sao lưu dữ liệu vào bộ nhớ'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Xử lý sao lưu dữ liệu
                    _showBackupDialog();
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Khôi phục dữ liệu'),
                  subtitle: const Text('Khôi phục từ bản sao lưu'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Xử lý khôi phục dữ liệu
                    _showRestoreDialog();
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Xuất dữ liệu'),
                  subtitle: const Text('Xuất dữ liệu ra file'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Xử lý xuất dữ liệu
                  },
                ),
              ],
            ),

            const SizedBox(height: 16),

            // THÔNG TIN ỨNG DỤNG
            _buildSectionCard(
              title: 'Thông tin ứng dụng',
              icon: Icons.info,
              children: [
                ListTile(
                  title: const Text('Phiên bản'),
                  subtitle: const Text('1.0.0'),
                ),
                const Divider(),
                ListTile(
                  title: const Text('Giấy phép'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Hiển thị thông tin giấy phép
                  },
                ),
                const Divider(),
                ListTile(
                  title: const Text('Chính sách bảo mật'),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 16),
                  onTap: () {
                    // Hiển thị chính sách bảo mật
                  },
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSectionCard({
    required String title,
    required IconData icon,
    required List<Widget> children,
  }) {
    return Card(
      elevation: 2,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: AppColors.primary, size: 22),
                const SizedBox(width: 10),
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: AppColors.primary,
                  ),
                ),
              ],
            ),
            const Divider(height: 24),
            ...children,
          ],
        ),
      ),
    );
  }

  Widget _buildTextField({
    required String label,
    required TextEditingController controller,
    required IconData icon,
    int maxLines = 1,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: label,
          prefixIcon: Icon(icon, color: Colors.grey[600]),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: Colors.grey[300]!),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: const BorderSide(color: AppColors.primary, width: 2),
          ),
          contentPadding: const EdgeInsets.symmetric(
            vertical: 16,
            horizontal: 16,
          ),
          filled: true,
          fillColor: Colors.white,
        ),
      ),
    );
  }

  void _showSelectionDialog({
    required String title,
    required List<String> options,
    required String selectedOption,
    required Function(String) onSelected,
  }) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children:
                    options.map((option) {
                      return RadioListTile<String>(
                        title: Text(option),
                        value: option,
                        groupValue: selectedOption,
                        onChanged: (value) {
                          Navigator.of(context).pop();
                          if (value != null) {
                            onSelected(value);
                          }
                        },
                        activeColor: AppColors.primary,
                      );
                    }).toList(),
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(),
                child: const Text('Hủy'),
              ),
            ],
          ),
    );
  }

  void _showNumberInputDialog({
    required String title,
    required String initialValue,
    required Function(String) onChanged,
  }) {
    final TextEditingController controller = TextEditingController(
      text: initialValue,
    );

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: Text(title),
            content: TextField(
              controller: controller,
              keyboardType: TextInputType.number,
              decoration: const InputDecoration(border: OutlineInputBorder()),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                style: TextButton.styleFrom(),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                  onChanged(controller.text);
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                child: const Text('Lưu'),
              ),
            ],
          ),
    );
  }

  void _showManageBankAccountsDialog() {
    // Giả định các tài khoản ngân hàng đã có
    final List<Map<String, String>> bankAccounts = [
      {
        'bank': 'Vietcombank',
        'number': '1234567890',
        'name': 'Nguyễn Văn A',
        'branch': 'TP.HCM',
      },
      {
        'bank': 'BIDV',
        'number': '0987654321',
        'name': 'Nguyễn Văn A',
        'branch': 'Hà Nội',
      },
      {
        'bank': 'Techcombank',
        'number': '1122334455',
        'name': 'Nguyễn Văn A',
        'branch': 'Đà Nẵng',
      },
    ];

    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Quản lý tài khoản ngân hàng'),
            content: SizedBox(
              width: double.maxFinite,
              child: ListView.separated(
                shrinkWrap: true,
                itemCount: bankAccounts.length,
                separatorBuilder: (_, __) => const Divider(),
                itemBuilder: (context, index) {
                  final account = bankAccounts[index];
                  return ListTile(
                    title: Text(account['bank']!),
                    subtitle: Text(
                      '${account['number']} - ${account['branch']}',
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Xử lý chỉnh sửa tài khoản
                      },
                    ),
                  );
                },
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Đóng'),
              ),
              TextButton(
                onPressed: () {
                  // Xử lý thêm tài khoản mới
                  Navigator.of(context).pop();
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                child: const Text('Thêm tài khoản'),
              ),
            ],
          ),
    );
  }

  void _showBackupDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Sao lưu dữ liệu'),
            content: const Text(
              'Bạn có muốn sao lưu tất cả dữ liệu hiện tại không?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  // Xử lý sao lưu dữ liệu
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã sao lưu dữ liệu thành công'),
                    ),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: AppColors.primary),
                child: const Text('Sao lưu'),
              ),
            ],
          ),
    );
  }

  void _showRestoreDialog() {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Khôi phục dữ liệu'),
            content: const Text(
              'Dữ liệu hiện tại sẽ bị ghi đè. Bạn có chắc chắn muốn khôi phục dữ liệu từ bản sao lưu không?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.of(context).pop(),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  // Xử lý khôi phục dữ liệu
                  Navigator.of(context).pop();
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Đã khôi phục dữ liệu thành công'),
                    ),
                  );
                },
                style: TextButton.styleFrom(foregroundColor: Colors.red),
                child: const Text('Khôi phục'),
              ),
            ],
          ),
    );
  }

  void _saveSettings() {
    // Lưu các cài đặt vào SharedPreferences
    // Trong ứng dụng thật, nên sử dụng SharedPreferences hoặc Hive để lưu các cài đặt

    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đã lưu cài đặt thành công')));
  }
}
