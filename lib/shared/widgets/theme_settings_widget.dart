import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../theme/app_theme.dart';

class ThemeSettingsWidget extends ConsumerWidget {
  const ThemeSettingsWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentThemeMode = ref.watch(themeModeProvider);

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              'Theme Settings',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            ListTile(
              title: const Text('System'),
              subtitle: const Text('Follow system setting'),
              leading: const Icon(Icons.brightness_auto),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.system,
                groupValue: currentThemeMode,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(themeModeProvider.notifier).state = value;
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Light'),
              subtitle: const Text('Light theme'),
              leading: const Icon(Icons.brightness_high),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.light,
                groupValue: currentThemeMode,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(themeModeProvider.notifier).state = value;
                  }
                },
              ),
            ),
            ListTile(
              title: const Text('Dark'),
              subtitle: const Text('Dark theme'),
              leading: const Icon(Icons.brightness_2),
              trailing: Radio<ThemeMode>(
                value: ThemeMode.dark,
                groupValue: currentThemeMode,
                onChanged: (value) {
                  if (value != null) {
                    ref.read(themeModeProvider.notifier).state = value;
                  }
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
