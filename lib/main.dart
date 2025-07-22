import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

// Import your GoRouter configuration file (you will create this next)
import 'package:pocket_vault/navigation/app_router.dart'; 

// Import your custom theme file (you will create this next)
//import 'package:pocket_vault/shared/theme/app_theme.dart';

// The main function is the entry point of the app.
void main() async {
  // 1. Ensure Flutter bindings are initialized.
  // This is required before using any plugins or async operations in main.
  WidgetsFlutterBinding.ensureInitialized();

  // TODO: Add any other app startup services here later
  // e.g., setup notifications, initialize analytics, etc.
  
  // 2. Wrap the entire app in a ProviderScope.
  // This is what makes Riverpod available to all widgets in the app.
  runApp(const ProviderScope(child: MyApp()));
}


// MyApp is now the root widget of your application.
class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 3. Get the GoRouter instance from your router file.
    // We make it a provider so it can be accessed/mocked for tests.
    final router = ref.watch(goRouterProvider);

    return MaterialApp.router(
      // --- ROUTING ---
      // Use the .router constructor to integrate GoRouter.
      routerConfig: router,

      // --- THEME ---
      // Use our custom Material 3 theme.
      //theme: ref.watch(appThemeProvider),
      // TODO: Add darkTheme later: darkTheme: AppTheme.darkTheme,
      
      // --- GENERAL ---
      title: 'PocketVault',
      debugShowCheckedModeBanner: false, // Hides the "debug" banner in development
    );
  }
}