import 'package:flutter/material.dart';

class AccessScreen extends StatelessWidget {
  const AccessScreen({required this.onContinueOffline, super.key});

  final VoidCallback onContinueOffline;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: SafeArea(
        child: LayoutBuilder(
          builder: (context, constraints) => SingleChildScrollView(
            padding: const EdgeInsets.all(24),
            child: ConstrainedBox(
              constraints: BoxConstraints(
                minHeight: constraints.maxHeight - 48,
                maxWidth: 480,
              ),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Adventure Vault Character',
                      style: theme.textTheme.headlineMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 12),
                    Text(
                      'Acceso a personaje offline con espacio reservado para '
                      'cuenta online futura.',
                      style: theme.textTheme.bodyLarge,
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 32),
                    Card(
                      child: Padding(
                        padding: const EdgeInsets.all(20),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Text(
                              'Login online',
                              style: theme.textTheme.titleLarge?.copyWith(
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              'Placeholder visible para una futura integracion '
                              'de cuenta. No bloquea el MVP offline.',
                              style: theme.textTheme.bodyMedium,
                            ),
                            const SizedBox(height: 16),
                            const TextField(
                              enabled: false,
                              decoration: InputDecoration(
                                labelText: 'Correo',
                                hintText: 'proximamente',
                              ),
                            ),
                            const SizedBox(height: 12),
                            const TextField(
                              enabled: false,
                              obscureText: true,
                              decoration: InputDecoration(
                                labelText: 'Contrasena',
                                hintText: 'proximamente',
                              ),
                            ),
                            const SizedBox(height: 16),
                            const FilledButton.tonal(
                              onPressed: null,
                              child: Text('Login online'),
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    FilledButton(
                      onPressed: onContinueOffline,
                      child: const Text('Continuar offline'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
