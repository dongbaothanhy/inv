import '../../domain/entities/settings_entity.dart';

abstract class SettingsView {
  void showLoading();
  void hideLoading();
  void showError(String message);
  void updateSettings(SettingsEntity settings);
}
