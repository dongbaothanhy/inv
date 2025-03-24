import 'package:flutter/material.dart';
import '../theme/colors.dart';
import 'add_category_screen.dart';
import '../widgets/shared_drawer.dart';

class CategoryScreen extends StatefulWidget {
  const CategoryScreen({super.key});

  @override
  State<CategoryScreen> createState() => _CategoryScreenState();
}

class _CategoryScreenState extends State<CategoryScreen> {
  // Giả lập dữ liệu danh mục
  final List<Map<String, dynamic>> _categories = [
    {'id': 1, 'name': 'Thực phẩm', 'type': 'product', 'childCount': 5},
    {'id': 2, 'name': 'Đồ uống', 'type': 'product', 'childCount': 3},
    {'id': 3, 'name': 'Dịch vụ spa', 'type': 'service', 'childCount': 2},
    {'id': 4, 'name': 'Dịch vụ sửa chữa', 'type': 'service', 'childCount': 0},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text(
          'Danh mục',
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.search, color: Colors.white),
            onPressed: () {
              // Xử lý tìm kiếm
            },
          ),
        ],
      ),
      drawer: const SharedDrawer(currentIndex: 7), // Giả sử danh mục có index 7
      body:
          _categories.isEmpty
              ? _buildEmptyState()
              : ListView.builder(
                padding: const EdgeInsets.all(16),
                itemCount: _categories.length,
                itemBuilder: (context, index) {
                  final category = _categories[index];
                  return _buildCategoryItem(category);
                },
              ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: AppColors.fabGreen,
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddCategoryScreen()),
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
          Icon(Icons.category_outlined, size: 80, color: Colors.grey[400]),
          const SizedBox(height: 16),
          Text(
            'Chưa có danh mục nào',
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Nhấn nút + để thêm danh mục mới',
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }

  Widget _buildCategoryItem(Map<String, dynamic> category) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        leading: CircleAvatar(
          backgroundColor:
              category['type'] == 'product'
                  ? AppColors.primary.withAlpha(50)
                  : Colors.orange.withAlpha(50),
          child: Icon(
            category['type'] == 'product'
                ? Icons.inventory_2_outlined
                : Icons.miscellaneous_services_outlined,
            color:
                category['type'] == 'product'
                    ? AppColors.primary
                    : Colors.orange,
          ),
        ),
        title: Text(
          category['name'],
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 16),
        ),
        subtitle: Text(
          category['type'] == 'product'
              ? 'Danh mục sản phẩm'
              : 'Danh mục dịch vụ',
          style: TextStyle(fontSize: 14, color: Colors.grey[600]),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (category['childCount'] > 0)
              Chip(
                label: Text(
                  '${category['childCount']}',
                  style: const TextStyle(fontSize: 12, color: Colors.white),
                ),
                backgroundColor: AppColors.primary,
                padding: EdgeInsets.zero,
                visualDensity: VisualDensity.compact,
              ),
            const SizedBox(width: 8),
            PopupMenuButton<String>(
              icon: const Icon(Icons.more_vert),
              onSelected: (value) {
                if (value == 'edit') {
                  // Xử lý sửa
                } else if (value == 'delete') {
                  _showDeleteDialog(category);
                }
              },
              itemBuilder:
                  (context) => [
                    const PopupMenuItem(
                      value: 'edit',
                      child: Row(
                        children: [
                          Icon(Icons.edit, size: 20),
                          SizedBox(width: 8),
                          Text('Sửa'),
                        ],
                      ),
                    ),
                    const PopupMenuItem(
                      value: 'delete',
                      child: Row(
                        children: [
                          Icon(Icons.delete, color: Colors.red, size: 20),
                          SizedBox(width: 8),
                          Text('Xóa', style: TextStyle(color: Colors.red)),
                        ],
                      ),
                    ),
                  ],
            ),
          ],
        ),
        onTap: () {
          // Xử lý khi nhấn vào danh mục
        },
      ),
    );
  }

  void _showDeleteDialog(Map<String, dynamic> category) {
    showDialog(
      context: context,
      builder:
          (context) => AlertDialog(
            title: const Text('Xóa danh mục'),
            content: Text(
              'Bạn có chắc chắn muốn xóa danh mục "${category['name']}"?',
            ),
            actions: [
              TextButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Hủy'),
              ),
              TextButton(
                onPressed: () {
                  // Xử lý xóa danh mục
                  setState(() {
                    _categories.removeWhere(
                      (item) => item['id'] == category['id'],
                    );
                  });
                  Navigator.pop(context);
                },
                child: const Text('Xóa', style: TextStyle(color: Colors.red)),
              ),
            ],
          ),
    );
  }
}
