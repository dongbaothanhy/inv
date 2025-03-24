import 'package:flutter/material.dart';
import '../theme/colors.dart';

class AddProductScreen extends StatefulWidget {
  const AddProductScreen({super.key});

  @override
  State<AddProductScreen> createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _sellingPriceController = TextEditingController();
  final _purchasePriceController = TextEditingController();
  final _stockQuantityController = TextEditingController();
  final _unitController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _categoryController = TextEditingController();
  bool _trackInventory = true;
  bool _isHidden = false;

  @override
  void dispose() {
    _nameController.dispose();
    _sellingPriceController.dispose();
    _purchasePriceController.dispose();
    _stockQuantityController.dispose();
    _unitController.dispose();
    _descriptionController.dispose();
    _categoryController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Thêm mặt hàng',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.check, color: Colors.white),
            onPressed: () {
              if (_formKey.currentState?.validate() ?? false) {
                // Lưu thông tin sản phẩm
                Navigator.pop(context);
              }
            },
          ),
        ],
      ),
      body: Form(
        key: _formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Thông tin cơ bản sản phẩm
              _buildSectionCard(
                title: 'Thông tin cơ bản',
                icon: Icons.inventory_2_outlined,
                children: [
                  _buildTextField(
                    label: 'Tên sản phẩm',
                    controller: _nameController,
                    icon: Icons.label_outline,
                    isRequired: true,
                  ),
                  _buildTextField(
                    label: 'Danh mục',
                    controller: _categoryController,
                    icon: Icons.category_outlined,
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Thông tin giá
              _buildSectionCard(
                title: 'Thông tin giá',
                icon: Icons.attach_money,
                children: [
                  _buildTextField(
                    label: 'Giá bán',
                    controller: _sellingPriceController,
                    icon: Icons.sell_outlined,
                    keyboardType: TextInputType.number,
                    isRequired: true,
                  ),
                  _buildTextField(
                    label: 'Giá nhập',
                    controller: _purchasePriceController,
                    icon: Icons.shopping_cart_outlined,
                    keyboardType: TextInputType.number,
                  ),
                  _buildTextField(
                    label: 'Đơn vị tính',
                    controller: _unitController,
                    icon: Icons.straighten_outlined,
                    hintText: 'cái, kg, hộp, thùng...',
                  ),
                ],
              ),

              const SizedBox(height: 16),

              // Thông tin tồn kho
              _buildSectionCard(
                title: 'Thông tin tồn kho',
                icon: Icons.inventory,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 16.0),
                    child: Row(
                      children: [
                        Icon(
                          _trackInventory
                              ? Icons.check_box
                              : Icons.check_box_outline_blank,
                          color: AppColors.primary,
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        const Text(
                          'Theo dõi tồn kho',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                        const Spacer(),
                        Switch(
                          value: _trackInventory,
                          onChanged: (bool value) {
                            setState(() {
                              _trackInventory = value;
                            });
                          },
                          activeColor: AppColors.fabGreen,
                        ),
                      ],
                    ),
                  ),
                  if (_trackInventory)
                    _buildTextField(
                      label: 'Số lượng tồn kho',
                      controller: _stockQuantityController,
                      icon: Icons.warehouse_outlined,
                      keyboardType: TextInputType.number,
                    ),
                ],
              ),

              const SizedBox(height: 16),

              // Mô tả sản phẩm
              _buildSectionCard(
                title: 'Mô tả sản phẩm',
                icon: Icons.description_outlined,
                children: [
                  _buildTextField(
                    label: 'Mô tả chi tiết',
                    controller: _descriptionController,
                    icon: Icons.notes,
                    maxLines: 4,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(top: 8.0),
                    child: Row(
                      children: [
                        Icon(
                          _isHidden ? Icons.visibility_off : Icons.visibility,
                          color: Colors.grey[600],
                          size: 20,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Không hiển thị sản phẩm này cho khách hàng',
                            style: TextStyle(
                              color: Colors.grey[700],
                              fontSize: 15,
                            ),
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
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Nút "Thêm hình ảnh"
              Container(
                width: double.infinity,
                height: 50,
                margin: const EdgeInsets.only(bottom: 16),
                child: OutlinedButton.icon(
                  onPressed: () {
                    // Thêm logic chọn hình ảnh ở đây
                  },
                  icon: const Icon(Icons.add_photo_alternate_outlined),
                  label: const Text('Thêm hình ảnh sản phẩm'),
                  style: OutlinedButton.styleFrom(
                    foregroundColor: AppColors.primary,
                    side: const BorderSide(color: AppColors.primary),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              // Nút lưu
              SizedBox(
                width: double.infinity,
                height: 50,
                child: ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState?.validate() ?? false) {
                      // Lưu thông tin sản phẩm
                      Navigator.pop(context);
                    }
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.fabGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 2,
                  ),
                  child: const Text(
                    'Lưu sản phẩm',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
                  ),
                ),
              ),
            ],
          ),
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
    IconData? icon,
    bool isRequired = false,
    int maxLines = 1,
    TextInputType keyboardType = TextInputType.text,
    String? hintText,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: TextFormField(
        controller: controller,
        keyboardType: keyboardType,
        maxLines: maxLines,
        decoration: InputDecoration(
          labelText: isRequired ? '$label *' : label,
          hintText: hintText,
          prefixIcon: icon != null ? Icon(icon, color: Colors.grey[600]) : null,
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
          floatingLabelBehavior: FloatingLabelBehavior.auto,
        ),
        validator:
            isRequired
                ? (value) {
                  if (value == null || value.isEmpty) {
                    return 'Vui lòng nhập $label';
                  }
                  return null;
                }
                : null,
      ),
    );
  }
}
