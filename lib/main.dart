import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:pocket_vault/core/database/seed_data.dart';
import 'package:pocket_vault/features/documents/presentation/providers/document_providers.dart';
import 'package:pocket_vault/navigation/app_router.dart';
import 'package:pocket_vault/shared/theme/app_theme.dart';

// The main function is the entry point of the app.
void main() async {
  // 1. Ensure Flutter bindings are initialized.
  WidgetsFlutterBinding.ensureInitialized();

  // 2. Create a ProviderContainer. This is a special object that lets us
  // access providers *outside* of the widget tree. It's perfect for
  // initialization scripts like our seeder.
  final container = ProviderContainer();

  // 3. SEEDING LOGIC (Debug Mode Only)
  // This block will ONLY run when you are in debug mode (e.g., `flutter run`).
  // It will be completely removed from your final release app.
  if (kDebugMode) {
    // We use the container to "read" the appDatabaseProvider, just like
    // you would use "ref.read" inside a widget.
    final db = container.read(appDatabaseProvider);
    // Call our seeder function with the database instance.
    await SeedData.seedDatabase(db);
  }

  // 4. Run the app.
  // Instead of a normal ProviderScope, we use UncontrolledProviderScope
  // and pass it the container we just created. This ensures that the
  // providers used for seeding are the *exact same instances* used by the app.
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MyApp(),
    ),
  );
}

// MyApp is now the root widget of your application.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Get the GoRouter instance from its provider.
    final router = ref.watch(goRouterProvider);
    
    // Get the Theme instance from its provider.
    final theme = ref.watch(themeDataProvider);
    final darkTheme = ref.watch(darkThemeDataProvider);
    final themeMode = ref.watch(themeModeProvider);

    return MaterialApp.router(
      // --- ROUTING ---
      routerConfig: router,

      // --- THEME ---
      // Use our custom Material 3 theme.
      theme: theme,
      darkTheme: darkTheme,
      themeMode: themeMode,
      
      // --- GENERAL ---
      title: 'PocketVault',
      debugShowCheckedModeBanner: false,
    );
  }
}