import '../views/settings_view.dart';
import '../../domain/usecases/get_settings_usecase.dart';
import '../../domain/usecases/update_settings_usecase.dart';
import '../../domain/entities/settings_entity.dart';

class SettingsPresenter {
  final SettingsView _view;
  final GetSettingsUseCase _getSettingsUseCase;
  final UpdateSettingsUseCase _updateSettingsUseCase;

  SettingsPresenter(
    this._view,
    this._getSettingsUseCase,
    this._updateSettingsUseCase,
  );

  void loadSettings() async {
    try {
      _view.showLoading();
      final settings = await _getSettingsUseCase.execute();
      _view.updateSettings(settings);
    } catch (e) {
      _view.showError(e.toString());
    } finally {
      _view.hideLoading();
    }
  }

  Future<void> updateSettings(SettingsEntity settings) async {
    try {
      _view.showLoading();
      await _updateSettingsUseCase.execute(settings);
    } catch (e) {
      _view.showError(e.toString());
    } finally {
      _view.hideLoading();
    }
  }
}
