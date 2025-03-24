import 'package:flutter/material.dart';
import '../theme/colors.dart';
import '../utils/responsive_helper.dart';

class CreateOrderScreen extends StatefulWidget {
  const CreateOrderScreen({super.key});

  @override
  State<CreateOrderScreen> createState() => _CreateOrderScreenState();
}

class _CreateOrderScreenState extends State<CreateOrderScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _customerController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _deliveryDateController = TextEditingController();
  final TextEditingController _addressController = TextEditingController();
  final TextEditingController _amountController = TextEditingController();
  final TextEditingController _noteController = TextEditingController();

  String _paymentStatus = 'Chưa thanh toán';
  String _orderStatus = 'Mới';

  final List<String> _paymentStatusOptions = [
    'Chưa thanh toán',
    'Đã thanh toán một phần',
    'Đã thanh toán đầy đủ',
  ];

  final List<String> _orderStatusOptions = [
    'Mới',
    'Đã xác nhận',
    'Đang chuẩn bị',
    'Đang giao hàng',
    'Đã giao hàng',
    'Đã hủy',
  ];

  @override
  void dispose() {
    _customerController.dispose();
    _dateController.dispose();
    _deliveryDateController.dispose();
    _addressController.dispose();
    _amountController.dispose();
    _noteController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    // Thiết lập giá trị mặc định
    _dateController.text = DateTime.now().toString().split(' ')[0];
    // Mặc định ngày giao hàng là 3 ngày sau
    final deliveryDate = DateTime.now().add(const Duration(days: 3));
    _deliveryDateController.text = deliveryDate.toString().split(' ')[0];
  }

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
          backgroundColor: const Color(0xFF4285f4),
          title: Text(
            'Tạo đơn hàng mới',
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
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Thông tin khách hàng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _customerController,
                  decoration: InputDecoration(
                    labelText: 'Khách hàng',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.person),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tên khách hàng';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: TextFormField(
                        controller: _dateController,
                        decoration: InputDecoration(
                          labelText: 'Ngày đặt hàng',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.calendar_today),
                        ),
                        readOnly: true,
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now(),
                            firstDate: DateTime(2000),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null && mounted) {
                            setState(() {
                              _dateController.text =
                                  pickedDate.toString().split(' ')[0];
                            });
                          }
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: TextFormField(
                        controller: _deliveryDateController,
                        decoration: InputDecoration(
                          labelText: 'Ngày giao hàng',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.local_shipping),
                        ),
                        readOnly: true,
                        onTap: () async {
                          final DateTime? pickedDate = await showDatePicker(
                            context: context,
                            initialDate: DateTime.now().add(
                              const Duration(days: 3),
                            ),
                            firstDate: DateTime.now(),
                            lastDate: DateTime(2101),
                          );
                          if (pickedDate != null && mounted) {
                            setState(() {
                              _deliveryDateController.text =
                                  pickedDate.toString().split(' ')[0];
                            });
                          }
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _addressController,
                  decoration: InputDecoration(
                    labelText: 'Địa chỉ giao hàng',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.location_on),
                  ),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập địa chỉ giao hàng';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 24),
                Text(
                  'Thông tin đơn hàng',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _orderStatus,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: 'Trạng thái đơn hàng',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.local_shipping),
                        ),
                        items:
                            _orderStatusOptions.map((status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(
                                  status,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _orderStatus = newValue!;
                          });
                        },
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: DropdownButtonFormField<String>(
                        value: _paymentStatus,
                        isExpanded: true,
                        decoration: InputDecoration(
                          labelText: 'Trạng thái thanh toán',
                          border: OutlineInputBorder(),
                          prefixIcon: Icon(Icons.payment),
                        ),
                        items:
                            _paymentStatusOptions.map((status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Text(
                                  status,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              );
                            }).toList(),
                        onChanged: (newValue) {
                          setState(() {
                            _paymentStatus = newValue!;
                          });
                        },
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _amountController,
                  decoration: InputDecoration(
                    labelText: 'Tổng tiền',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.monetization_on),
                  ),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Vui lòng nhập tổng tiền';
                    }
                    return null;
                  },
                ),
                const SizedBox(height: 16),
                TextFormField(
                  controller: _noteController,
                  decoration: InputDecoration(
                    labelText: 'Ghi chú',
                    border: OutlineInputBorder(),
                    prefixIcon: Icon(Icons.note),
                  ),
                  maxLines: 3,
                ),
                const SizedBox(height: 24),
                Text(
                  'Danh sách sản phẩm',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.black87,
                  ),
                ),
                const SizedBox(height: 16),
                Card(
                  elevation: 2,
                  child: Padding(
                    padding: const EdgeInsets.all(12.0),
                    child: Row(
                      children: [
                        Expanded(
                          child: Text(
                            'Thêm sản phẩm vào đơn hàng',
                            style: TextStyle(fontSize: 16),
                          ),
                        ),
                        IconButton(
                          icon: Icon(
                            Icons.add_circle,
                            color: AppColors.primary,
                          ),
                          onPressed: () {
                            // Hiển thị dialog thêm sản phẩm
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 32),
                SizedBox(
                  width: double.infinity,
                  height: 50,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      if (_formKey.currentState!.validate()) {
                        _saveOrder();
                      }
                    },
                    child: Text('LƯU ĐƠN HÀNG'),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<void> _saveOrder() async {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(const SnackBar(content: Text('Đang lưu đơn hàng...')));

    await Future.delayed(const Duration(seconds: 1));

    if (mounted) {
      Navigator.pop(context);
    }
  }
}
