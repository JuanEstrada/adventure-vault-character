import 'package:adventure_vault_character/src/app/app_controller.dart';
import 'package:adventure_vault_character/src/core/navigation/app_screen.dart';
import 'package:adventure_vault_character/src/features/access/presentation/access_screen.dart';
import 'package:adventure_vault_character/src/features/bootstrap/presentation/bootstrap_screen.dart';
import 'package:adventure_vault_character/src/features/characters/data/in_memory_character_repository.dart';
import 'package:adventure_vault_character/src/features/main_menu/presentation/main_menu_screen.dart';
import 'package:flutter/material.dart';

class AdventureVaultApp extends StatefulWidget {
  const AdventureVaultApp({super.key});

  @override
  State<AdventureVaultApp> createState() => _AdventureVaultAppState();
}

class _AdventureVaultAppState extends State<AdventureVaultApp> {
  late final AppController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AppController(
      characterRepository: InMemoryCharacterRepository.empty(),
    );
    _controller.initialize();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Adventure Vault Character',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(0xFF7C5C3B),
          brightness: Brightness.light,
        ),
        scaffoldBackgroundColor: const Color(0xFFF4EFE6),
        useMaterial3: true,
      ),
      home: ListenableBuilder(
        listenable: _controller,
        builder: (context, _) {
          final state = _controller.state;
          return switch (state.screen) {
            AppScreen.bootstrap => BootstrapScreen(
                isLoading: state.isInitializing,
                errorMessage: state.errorMessage,
                onRetry: _controller.initialize,
              ),
            AppScreen.access => AccessScreen(
                onContinueOffline: _controller.continueOffline,
              ),
            AppScreen.mainMenu => MainMenuScreen(
                characterSummaries: state.characterSummaries,
              ),
          };
        },
      ),
    );
  }
}
