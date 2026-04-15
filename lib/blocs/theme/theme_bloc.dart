import 'package:flutter_bloc/flutter_bloc.dart';
import '../../services/shared_preferences_service.dart';
import 'theme_event.dart';
import 'theme_state.dart';

class ThemeBloc extends Bloc<ThemeEvent, ThemeState> {
  final SharedPreferencesService _prefsService;

  ThemeBloc(this._prefsService) : super(const ThemeState(isDark: false)) {
    on<LoadTheme>(_onLoadTheme);
    on<ToggleTheme>(_onToggleTheme);
  }

  Future<void> _onLoadTheme(
    LoadTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final isDark = await _prefsService.getTheme();
    emit(ThemeState(isDark: isDark));
  }

  Future<void> _onToggleTheme(
    ToggleTheme event,
    Emitter<ThemeState> emit,
  ) async {
    final newIsDark = !state.isDark;
    await _prefsService.saveTheme(newIsDark);
    emit(ThemeState(isDark: newIsDark));
  }
}
