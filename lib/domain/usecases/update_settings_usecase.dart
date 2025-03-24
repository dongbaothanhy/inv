import '../entities/settings_entity.dart';
import '../repositories/settings_repository.dart';

class UpdateSettingsUseCase {
  final SettingsRepository _repository;

  UpdateSettingsUseCase(this._repository);

  Future<void> execute(SettingsEntity settings) async {
    await _repository.updateSettings(settings);
  }
}
