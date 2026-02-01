import 'package:flutter/material.dart';
import 'package:z_editor/l10n/app_localizations.dart';

class AboutScreen extends StatelessWidget {
  const AboutScreen({super.key, required this.onBack});

  final VoidCallback onBack;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context)!;
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        title: Text(
          l10n.softwareIntro,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22),
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: onBack,
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              l10n.zEditor,
              textAlign: TextAlign.center,
              style: theme.textTheme.headlineMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const SizedBox(height: 4),
            Text(
              l10n.pvzEditorSubtitle,
              textAlign: TextAlign.center,
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 18),
            _InfoCard(
              title: l10n.introSection,
              child: Text(
                l10n.introText,
                style: TextStyle(height: 1.5, color: theme.colorScheme.onSurface),
              ),
            ),
            _InfoCard(
              title: l10n.featuresSection,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Bullet(l10n.feature1),
                  _Bullet(l10n.feature2),
                  _Bullet(l10n.feature3),
                  _Bullet(l10n.feature4),
                ],
              ),
            ),
            _InfoCard(
              title: l10n.usageSection,
              child: Text(
                l10n.usageText,
                style: TextStyle(height: 1.5, color: theme.colorScheme.onSurface),
              ),
            ),
            _InfoCard(
              title: l10n.creditsSection,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _Bullet(l10n.authorLabel),
                  Text(l10n.authorName, style: TextStyle(color: theme.colorScheme.onSurface)),
                  _Bullet(l10n.thanksLabel),
                  Text(l10n.thanksNames, style: TextStyle(color: theme.colorScheme.onSurface)),
                ],
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.tagline,
              textAlign: TextAlign.center,
              style: theme.textTheme.titleMedium?.copyWith(
                color: theme.colorScheme.onSurfaceVariant,
              ),
            ),
            const SizedBox(height: 20),
            Text(
              l10n.version('1.1.5'),
              textAlign: TextAlign.center,
              style: theme.textTheme.bodySmall?.copyWith(color: Colors.grey),
            ),
          ],
        ),
      ),
    );
  }
}

class _InfoCard extends StatelessWidget {
  const _InfoCard({required this.title, required this.child});

  final String title;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      margin: const EdgeInsets.symmetric(vertical: 8),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: theme.textTheme.titleMedium?.copyWith(
                fontWeight: FontWeight.bold,
                color: theme.colorScheme.primary,
              ),
            ),
            const Divider(height: 16),
            child,
          ],
        ),
      ),
    );
  }
}

class _Bullet extends StatelessWidget {
  const _Bullet(this.text);

  final String text;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 2),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('• ', style: TextStyle(fontWeight: FontWeight.bold, color: theme.colorScheme.primary)),
          Expanded(child: Text(text, style: TextStyle(height: 1.5, color: theme.colorScheme.onSurface))),
        ],
      ),
    );
  }
}
