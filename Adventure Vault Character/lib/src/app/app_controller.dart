import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/character_repository.dart';
import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:flutter/foundation.dart';

@immutable
class AppState {
  const AppState({
    required this.screen,
    required this.isInitializing,
    required this.characterSummaries,
    this.errorMessage,
  });

  const AppState.initial()
      : screen = AppScreen.bootstrap,
        isInitializing = true,
        characterSummaries = const <CharacterSummary>[],
        errorMessage = null;

  final AppScreen screen;
  final bool isInitializing;
  final List<CharacterSummary> characterSummaries;
  final String? errorMessage;

  AppState copyWith({
    AppScreen? screen,
    bool? isInitializing,
    List<CharacterSummary>? characterSummaries,
    String? errorMessage,
    bool clearError = false,
  }) {
    return AppState(
      screen: screen ?? this.screen,
      isInitializing: isInitializing ?? this.isInitializing,
      characterSummaries: characterSummaries ?? this.characterSummaries,
      errorMessage: clearError ? null : errorMessage ?? this.errorMessage,
    );
  }
}

class AppController extends ChangeNotifier {
  AppController({required CharacterRepository characterRepository})
      : _characterRepository = characterRepository;

  final CharacterRepository _characterRepository;

  AppState _state = const AppState.initial();

  AppState get state => _state;

  Future<void> initialize() async {
    _state = _state.copyWith(isInitializing: true, clearError: true);
    notifyListeners();

    try {
      final summaries = await _characterRepository.getCharacterSummaries();
      _state = _state.copyWith(
        screen: AppScreen.access,
        isInitializing: false,
        characterSummaries: summaries,
        clearError: true,
      );
    } catch (_) {
      _state = _state.copyWith(
        isInitializing: false,
        errorMessage: 'No se pudo cargar el estado local de la app.',
      );
    }

    notifyListeners();
  }

  void continueOffline() {
    _state = _state.copyWith(screen: AppScreen.mainMenu, clearError: true);
    notifyListeners();
  }
}
