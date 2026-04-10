import 'package:flutter/material.dart';

class CompendiumImportScreen extends StatefulWidget {
  const CompendiumImportScreen({
    required this.onBack,
    required this.onOpenCompendiumPacks,
    required this.onImportXml,
    super.key,
  });

  final VoidCallback onBack;
  final VoidCallback onOpenCompendiumPacks;
  final Future<String?> Function(String rawXml) onImportXml;

  @override
  State<CompendiumImportScreen> createState() => _CompendiumImportScreenState();
}

class _CompendiumImportScreenState extends State<CompendiumImportScreen> {
  final TextEditingController _xmlController = TextEditingController();
  bool _isImporting = false;
  String? _statusMessage;
  String? _importedPreview;

  @override
  void dispose() {
    _xmlController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          onPressed: widget.onBack,
          icon: const Icon(Icons.arrow_back),
        ),
        title: const Text('Import XML'),
      ),
      body: ListView(
        padding: const EdgeInsets.all(24),
        children: [
          Container(
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: const Color(0xFFE8DDCB),
              borderRadius: BorderRadius.circular(20),
              border: Border.all(color: const Color(0xFFD1BEA1)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Local pack registration',
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  'Paste FightClub-compatible XML to register it as an optional local pack. '
                  'This iteration validates structure, persists the pack in Manage packs, '
                  'and ingests compatible entries into the active catalog when the pack is enabled.',
                  style: theme.textTheme.bodyMedium,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: _xmlController,
            minLines: 14,
            maxLines: 20,
            decoration: const InputDecoration(
              labelText: 'XML content',
              alignLabelWithHint: true,
              border: OutlineInputBorder(),
              hintText:
                  '<compendium>\\n  <background>...</background>\\n</compendium>',
            ),
          ),
          const SizedBox(height: 12),
          if (_statusMessage != null)
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: _importedPreview == null
                    ? const Color(0xFFF8E6E2)
                    : const Color(0xFFE4F1E7),
                borderRadius: BorderRadius.circular(16),
                border: Border.all(
                  color: _importedPreview == null
                      ? const Color(0xFFE0B5AA)
                      : const Color(0xFFB9D5BE),
                ),
              ),
              child: Text(_statusMessage!),
            ),
          const SizedBox(height: 16),
          Wrap(
            spacing: 12,
            runSpacing: 12,
            children: [
              FilledButton(
                onPressed: _isImporting ? null : _handleImport,
                child: Text(_isImporting ? 'Registering...' : 'Register XML'),
              ),
              OutlinedButton(
                onPressed: _importedPreview == null
                    ? null
                    : widget.onOpenCompendiumPacks,
                child: const Text('Open packs'),
              ),
            ],
          ),
          if (_importedPreview != null) ...[
            const SizedBox(height: 20),
            Text(
              'Latest registration',
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.w700,
              ),
            ),
            const SizedBox(height: 8),
            Text(_importedPreview!, style: theme.textTheme.bodyMedium),
          ],
        ],
      ),
    );
  }

  Future<void> _handleImport() async {
    setState(() {
      _isImporting = true;
      _statusMessage = null;
    });

    final error = await widget.onImportXml(_xmlController.text);

    if (!mounted) {
      return;
    }

    setState(() {
      _isImporting = false;
      if (error != null) {
        _statusMessage = error;
        _importedPreview = null;
        return;
      }
      final preview = _buildPreview(_xmlController.text);
      _importedPreview = preview;
      _statusMessage =
          'XML registered locally. You can now manage it as an optional pack.';
    });
  }

  String _buildPreview(String rawXml) {
    final normalizedXml = rawXml.trim();
    final titleMatch = RegExp(
      r'<name>([^<]+)</name>',
      caseSensitive: false,
    ).firstMatch(normalizedXml);
    final title = titleMatch?.group(1)?.trim();
    final supportedElementCount = RegExp(
      r'<(background|race|class|spell|feat|monster)\b',
      caseSensitive: false,
    ).allMatches(normalizedXml).length;
    final resolvedTitle = title == null || title.isEmpty
        ? 'Imported XML pack'
        : title;
    return '$resolvedTitle • $supportedElementCount compatible entries detected';
  }
}
