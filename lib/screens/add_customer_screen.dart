import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AddCustomerScreen extends StatefulWidget {
  const AddCustomerScreen({super.key});

  @override
  State<AddCustomerScreen> createState() => _AddCustomerScreenState();
}

class _AddCustomerScreenState extends State<AddCustomerScreen> {
  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _addressController = TextEditingController();
  final _contactController = TextEditingController();
  final _phone1Controller = TextEditingController();
  final _additionalNotesController = TextEditingController();
  final _internalNotesController = TextEditingController();
  bool _isHidden = false;

  @override
  void dispose() {
    _nameController.dispose();
    _emailController.dispose();
    _addressController.dispose();
    _contactController.dispose();
    _phone1Controller.dispose();
    _additionalNotesController.dispose();
    _internalNotesController.dispose();
    super.dispose();
  }

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
                _buildTextField('Tên', _nameController),
                _buildTextField('E-mail', _emailController),
                _buildTextField('Địa chỉ', _addressController),
                _buildTextField('Tiếp xúc', _contactController),

                // Nhóm các trường điện thoại
                const Text('Điện thoại', style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _phone1Controller,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Nhập số điện thoại',
                  ),
                ),
                const SizedBox(height: 24.0),

                // Nhóm các trường ghi chú
                const Text('Ghi chú', style: TextStyle(fontSize: 16.0)),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _additionalNotesController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Ghi chú bổ sung',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 8.0),
                TextField(
                  controller: _internalNotesController,
                  decoration: const InputDecoration(
                    border: UnderlineInputBorder(),
                    hintText: 'Ghi chú nội bộ',
                  ),
                  maxLines: 2,
                ),
                const SizedBox(height: 24.0),

                // Switch ẩn/hiện
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        'không hiển thị cho khách hàng / nhà cung cấp',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    ),
                    Switch(
                      value: _isHidden,
                      onChanged: (bool value) {
                        setState(() {
                          _isHidden = value;
                        });
                      },
                      activeColor: AppColors.fabGreen,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildTextField(String label, TextEditingController controller) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: const TextStyle(fontSize: 16.0)),
        const SizedBox(height: 8.0),
        TextField(
          controller: controller,
          decoration: InputDecoration(
            border: const UnderlineInputBorder(),
            hintText: 'Nhập ${label.toLowerCase()}',
          ),
        ),
        const SizedBox(height: 24.0),
      ],
    );
  }
}
