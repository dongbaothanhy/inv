import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../theme/colors.dart';

class CreateInvoiceScreen extends StatefulWidget {
  const CreateInvoiceScreen({super.key});

  @override
  State<CreateInvoiceScreen> createState() => _CreateInvoiceScreenState();
}

class _CreateInvoiceScreenState extends State<CreateInvoiceScreen> {
  final _formKey = GlobalKey<FormState>();
  final _customerController = TextEditingController();
  final _dateController = TextEditingController();
  final _dueDateController = TextEditingController();
  final _invoiceNumberController = TextEditingController();
  final _noteController = TextEditingController();
  final _discountController = TextEditingController(text: '0');
  final _taxRateController = TextEditingController(text: '10');

  String _paymentStatus = 'Chưa thanh toán';
  DateTime _selectedDate = DateTime.now();
  DateTime _selectedDueDate = DateTime.now().add(const Duration(days: 30));

  final NumberFormat _currencyFormatter = NumberFormat.currency(
    locale: 'vi_VN',
    symbol: 'đ',
  );

  // Danh sách sản phẩm trong hóa đơn (mẫu)
  final List<Map<String, dynamic>> _invoiceItems = [];

  final List<String> _paymentStatusOptions = [
    'Chưa thanh toán',
    'Đã thanh toán một phần',
    'Đã thanh toán đầy đủ',
  ];

  @override
  void initState() {
    super.initState();
    _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
    _dueDateController.text = DateFormat('dd/MM/yyyy').format(_selectedDueDate);

    // Tạo số hóa đơn mẫu
    final now = DateTime.now();
    _invoiceNumberController.text =
        'HD${now.year}${now.month.toString().padLeft(2, '0')}${now.day.toString().padLeft(2, '0')}${now.millisecond.toString().substring(0, 2)}';
  }

  @override
  void dispose() {
    _customerController.dispose();
    _dateController.dispose();
    _dueDateController.dispose();
    _invoiceNumberController.dispose();
    _noteController.dispose();
    _discountController.dispose();
    _taxRateController.dispose();
    super.dispose();
  }

  double get _subtotal {
    double total = 0;
    for (var item in _invoiceItems) {
      total += (item['price'] * item['quantity']);
    }
    return total;
  }

  double get _discount {
    return double.tryParse(_discountController.text) ?? 0;
  }

  double get _taxRate {
    return double.tryParse(_taxRateController.text) ?? 0;
  }

  double get _taxAmount {
    return (_subtotal - _discount) * _taxRate / 100;
  }

  double get _total {
    return _subtotal - _discount + _taxAmount;
  }

  Future<void> _selectDate(BuildContext context, bool isDueDate) async {
    final DateTime initialDate = isDueDate ? _selectedDueDate : _selectedDate;

    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: initialDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
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

    if (pickedDate != null) {
      setState(() {
        if (isDueDate) {
          _selectedDueDate = pickedDate;
          _dueDateController.text = DateFormat(
            'dd/MM/yyyy',
          ).format(_selectedDueDate);
        } else {
          _selectedDate = pickedDate;
          _dateController.text = DateFormat('dd/MM/yyyy').format(_selectedDate);
        }
      });
    }
  }

  void _addItem() {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
      ),
      builder: (context) {
        TextEditingController nameController = TextEditingController();
        TextEditingController quantityController = TextEditingController(
          text: '1',
        );
        TextEditingController priceController = TextEditingController();

        return StatefulBuilder(
          builder: (context, setState) {
            return Padding(
              padding: EdgeInsets.only(
                bottom: MediaQuery.of(context).viewInsets.bottom,
                top: 16,
                left: 16,
                right: 16,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Thêm sản phẩm/dịch vụ',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 16),
                  TextField(
                    controller: nameController,
                    decoration: const InputDecoration(
                      labelText: 'Tên sản phẩm/dịch vụ',
                      border: OutlineInputBorder(),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: quantityController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Số lượng',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                      const SizedBox(width: 12),
                      Expanded(
                        child: TextField(
                          controller: priceController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Đơn giá',
                            border: OutlineInputBorder(),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 24),
                  SizedBox(
                    width: double.infinity,
                    height: 48,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.primary,
                        foregroundColor: Colors.white,
                      ),
                      onPressed: () {
                        // Thêm sản phẩm vào hóa đơn
                        if (nameController.text.isNotEmpty &&
                            priceController.text.isNotEmpty) {
                          final quantity =
                              int.tryParse(quantityController.text) ?? 1;
                          final price =
                              double.tryParse(priceController.text) ?? 0;

                          this.setState(() {
                            _invoiceItems.add({
                              'name': nameController.text,
                              'quantity': quantity,
                              'price': price,
                            });
                          });
                          Navigator.pop(context);
                        }
                      },
                      child: const Text('Thêm vào hóa đơn'),
                    ),
                  ),
                  const SizedBox(height: 16),
                ],
              ),
            );
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Tạo hóa đơn mới',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          TextButton(
            onPressed: () {
              if (_formKey.currentState!.validate()) {
                _saveInvoice();
              }
            },
            child: const Text(
              'Lưu',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
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
              // Thông tin hóa đơn
              _buildSectionCard(
                title: 'Thông tin hóa đơn',
                icon: Icons.receipt_outlined,
                children: [
                  // Số hóa đơn
                  TextFormField(
                    controller: _invoiceNumberController,
                    decoration: const InputDecoration(
                      labelText: 'Số hóa đơn',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.tag),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập số hóa đơn';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Khách hàng
                  TextFormField(
                    controller: _customerController,
                    decoration: const InputDecoration(
                      labelText: 'Khách hàng',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.person_outline),
                    ),
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return 'Vui lòng nhập tên khách hàng';
                      }
                      return null;
                    },
                  ),
                  const SizedBox(height: 16),

                  // Ngày tạo và ngày đến hạn
                  Row(
                    children: [
                      Expanded(
                        child: TextFormField(
                          controller: _dateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Ngày tạo',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.calendar_today),
                          ),
                          onTap: () => _selectDate(context, false),
                        ),
                      ),
                      const SizedBox(width: 16),
                      Expanded(
                        child: TextFormField(
                          controller: _dueDateController,
                          readOnly: true,
                          decoration: const InputDecoration(
                            labelText: 'Ngày đến hạn',
                            border: OutlineInputBorder(),
                            prefixIcon: Icon(Icons.event),
                          ),
                          onTap: () => _selectDate(context, true),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),

                  // Trạng thái thanh toán
                  DropdownButtonFormField<String>(
                    value: _paymentStatus,
                    decoration: const InputDecoration(
                      labelText: 'Trạng thái thanh toán',
                      border: OutlineInputBorder(),
                      prefixIcon: Icon(Icons.payment),
                    ),
                    items:
                        _paymentStatusOptions.map((status) {
                          return DropdownMenuItem<String>(
                            value: status,
                            child: Text(status),
                          );
                        }).toList(),
                    onChanged: (newValue) {
                      if (newValue != null) {
                        setState(() {
                          _paymentStatus = newValue;
                        });
                      }
                    },
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Danh sách sản phẩm/dịch vụ
              _buildSectionCard(
                title: 'Danh sách sản phẩm/dịch vụ',
                icon: Icons.shopping_cart_outlined,
                children: [
                  // Danh sách hiện tại
                  if (_invoiceItems.isEmpty)
                    Container(
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Text(
                        'Chưa có sản phẩm/dịch vụ nào',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  else
                    ListView.separated(
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      itemCount: _invoiceItems.length,
                      separatorBuilder: (context, index) => const Divider(),
                      itemBuilder: (context, index) {
                        final item = _invoiceItems[index];
                        return Padding(
                          padding: const EdgeInsets.symmetric(vertical: 8.0),
                          child: Row(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Expanded(
                                flex: 3,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      item['name'],
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    const SizedBox(height: 4),
                                    Text(
                                      '${item['quantity']} x ${_currencyFormatter.format(item['price'])}',
                                      style: TextStyle(color: Colors.grey[600]),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                flex: 2,
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Text(
                                      _currencyFormatter.format(
                                        item['quantity'] * item['price'],
                                      ),
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 16,
                                      ),
                                    ),
                                    IconButton(
                                      icon: const Icon(
                                        Icons.delete_outline,
                                        color: Colors.red,
                                      ),
                                      onPressed: () {
                                        setState(() {
                                          _invoiceItems.removeAt(index);
                                        });
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        );
                      },
                    ),

                  const SizedBox(height: 16),

                  // Nút thêm sản phẩm
                  SizedBox(
                    width: double.infinity,
                    height: 50,
                    child: OutlinedButton.icon(
                      icon: const Icon(Icons.add),
                      label: const Text('Thêm sản phẩm/dịch vụ'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppColors.primary,
                      ),
                      onPressed: _addItem,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Tính toán hóa đơn
              _buildSectionCard(
                title: 'Tổng cộng',
                icon: Icons.calculate_outlined,
                children: [
                  // Tạm tính
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text('Tạm tính:'),
                      Text(_currencyFormatter.format(_subtotal)),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Giảm giá
                  Row(
                    children: [
                      const Expanded(child: Text('Giảm giá:')),
                      SizedBox(
                        width: 120,
                        child: TextFormField(
                          controller: _discountController,
                          keyboardType: TextInputType.number,
                          textAlign: TextAlign.right,
                          decoration: const InputDecoration(
                            isDense: true,
                            contentPadding: EdgeInsets.symmetric(
                              horizontal: 8,
                              vertical: 12,
                            ),
                            border: OutlineInputBorder(),
                          ),
                          onChanged: (value) {
                            setState(() {});
                          },
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 12),

                  // Thuế VAT
                  Row(
                    children: [
                      Expanded(
                        child: Row(
                          children: [
                            const Text('Thuế VAT ('),
                            SizedBox(
                              width: 50,
                              child: TextFormField(
                                controller: _taxRateController,
                                keyboardType: TextInputType.number,
                                textAlign: TextAlign.center,
                                decoration: const InputDecoration(
                                  isDense: true,
                                  contentPadding: EdgeInsets.symmetric(
                                    horizontal: 4,
                                    vertical: 8,
                                  ),
                                  border: OutlineInputBorder(),
                                ),
                                onChanged: (value) {
                                  setState(() {});
                                },
                              ),
                            ),
                            const Text('%):'),
                          ],
                        ),
                      ),
                      Text(_currencyFormatter.format(_taxAmount)),
                    ],
                  ),
                  const Divider(height: 24),

                  // Tổng cộng
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text(
                        'Tổng cộng:',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                        ),
                      ),
                      Text(
                        _currencyFormatter.format(_total),
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 18,
                          color: AppColors.primary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),

              const SizedBox(height: 24),

              // Ghi chú
              _buildSectionCard(
                title: 'Ghi chú',
                icon: Icons.note_alt_outlined,
                children: [
                  TextFormField(
                    controller: _noteController,
                    maxLines: 3,
                    decoration: const InputDecoration(
                      hintText: 'Thêm ghi chú cho hóa đơn',
                      border: OutlineInputBorder(),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 32),

              // Nút lưu
              SizedBox(
                width: double.infinity,
                height: 54,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.fabGreen,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _saveInvoice();
                    }
                  },
                  child: const Text(
                    'LƯU HÓA ĐƠN',
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
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

  Future<void> _saveInvoice() async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đang lưu hóa đơn...')));

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
