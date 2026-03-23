import 'package:adventure_vault_character/src/features/characters/domain/character_summary.dart';
import 'package:flutter/material.dart';

class CharacterSummaryCard extends StatelessWidget {
  const CharacterSummaryCard({required this.summary, super.key});

  final CharacterSummary summary;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Card(
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: SizedBox(
          width: 220,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Container(
                height: 160,
                color: const Color(0xFFDBC8AC),
                child: summary.portraitAssetPath == null
                    ? const Icon(Icons.shield_outlined, size: 54)
                    : Image.asset(summary.portraitAssetPath!,
                        fit: BoxFit.cover),
              ),
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      summary.name,
                      style: theme.textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    const SizedBox(height: 6),
                    Text(
                      '${summary.raceName}  •  ${summary.className}  •  Lv ${summary.level}',
                      style: theme.textTheme.bodyMedium,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
