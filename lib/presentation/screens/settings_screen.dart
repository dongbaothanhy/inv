import 'package:flutter/material.dart';
import '../../domain/entities/settings_entity.dart';
import '../../theme/colors.dart';
import '../views/settings_view.dart';
import '../presenters/settings_presenter.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import '../../data/repositories/settings_repository_impl.dart';

class SettingsScreen extends StatefulWidget {
  const SettingsScreen({super.key});

  @override
  State<SettingsScreen> createState() => _SettingsScreenState();
}

class _SettingsScreenState extends State<SettingsScreen>
    implements SettingsView {
  late final SettingsPresenter _presenter;
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    _presenter = SettingsPresenter(
      this,
      GetSettingsUseCase(SettingsRepositoryImpl()),
      UpdateSettingsUseCase(SettingsRepositoryImpl()),
    );
    _presenter.loadSettings();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: AppColors.primary,
        title: const Text('Cài đặt', style: TextStyle(color: Colors.white)),
      ),
      body:
          _isLoading
              ? const Center(child: CircularProgressIndicator())
              : ListView(
                children: [
                  _buildSettingItem(
                    icon: Icons.camera_alt,
                    title: 'Logo',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.business,
                    title: 'Thông tin công ty',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.draw,
                    title: 'Công ty chữ ký',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.add_circle_outline,
                    title: 'Thêm các trường',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.edit_note,
                    title: 'Ghi chú mặc định',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.language,
                    title: 'Ngôn ngữ / Tiền tệ / Ngày',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.edit,
                    title: 'Tùy chỉnh các trường',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.font_download,
                    title: 'Chú thích',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.style,
                    title: 'Bản mẫu',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.calculate,
                    title: 'Thuế',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.backup,
                    title: 'Sao lưu',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.shopping_cart_checkout,
                    title: 'Mua ngay',
                    color: const Color(0xFF007BA7),
                  ),
                  _buildSettingItem(
                    icon: Icons.restore,
                    title: 'Khôi phục mua hàng',
                    color: const Color(0xFF007BA7),
                  ),
                ],
              ),
    );
  }

  Widget _buildSettingItem({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return ListTile(
      leading: Icon(icon, color: color),
      title: Text(title),
      trailing: const Icon(Icons.chevron_right),
      onTap: () {
        // TODO: Handle navigation to specific setting screen
      },
    );
  }

  @override
  void showLoading() {
    setState(() => _isLoading = true);
  }

  @override
  void hideLoading() {
    setState(() => _isLoading = false);
  }

  @override
  void showError(String message) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text(message)));
  }

  @override
  void updateSettings(SettingsEntity settings) {
    setState(() {
      // Update UI with settings
    });
  }
}
