import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:adventure_vault_character/src/features/main_menu/presentation/character_card.dart';
import 'package:flutter/material.dart';

class MainMenuScreen extends StatelessWidget {
  const MainMenuScreen({
    required this.characterSummaries,
    required this.onCreateCharacter,
    required this.onOpenCharacter,
    super.key,
  });

  final List<CharacterSummary> characterSummaries;
  final VoidCallback onCreateCharacter;
  final ValueChanged<String> onOpenCharacter;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Adventure Vault Character'),
        actions: const [
          _TopAction(label: 'Compendio'),
          _TopAction(label: 'Reglas'),
          _TopAction(label: 'Settings'),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: const Color(0xFFE8DDCB),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Personajes',
                    style: theme.textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Entrada local para hoja de personaje, creacion guiada y '
                    'futuro flujo XML.',
                    style: theme.textTheme.bodyLarge,
                  ),
                  const SizedBox(height: 16),
                  Wrap(
                    spacing: 12,
                    runSpacing: 12,
                    children: [
                      FilledButton(
                        onPressed: onCreateCharacter,
                        child: const Text('Crear personaje nuevo'),
                      ),
                      OutlinedButton(
                        onPressed: () {},
                        child: const Text('LOAD XML'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: characterSummaries.isEmpty
                  ? Center(
                      child: Text(
                        'Todavia no hay personajes guardados. '
                        'Crear personaje nuevo debe permanecer visible.',
                        style: theme.textTheme.bodyLarge,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : ListView.separated(
                      scrollDirection: Axis.horizontal,
                      itemCount: characterSummaries.length,
                      separatorBuilder: (context, index) =>
                          const SizedBox(width: 16),
                      itemBuilder: (context, index) {
                        return CharacterSummaryCard(
                          summary: characterSummaries[index],
                          onTap: () =>
                              onOpenCharacter(characterSummaries[index].id),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TopAction extends StatelessWidget {
  const _TopAction({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4),
      child: TextButton(onPressed: () {}, child: Text(label)),
    );
  }
}
