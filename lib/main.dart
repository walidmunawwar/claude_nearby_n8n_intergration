import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'l10n/app_localizations.dart';
import 'providers/locale_provider.dart';
import 'screens/search_screen.dart';

/// Entry point of the application.
/// 
/// Sets up the app orientation and initializes the widget tree.
void main() {
  WidgetsFlutterBinding.ensureInitialized();
  
  // Allow both portrait and landscape orientations for better responsiveness
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  //   DeviceOrientation.portraitDown,
  //   DeviceOrientation.landscapeLeft,
  //   DeviceOrientation.landscapeRight,
  // ]);
  
  runApp(
    ChangeNotifierProvider(
      create: (context) => LocaleProvider(),
      child: const MyApp(),
    ),
  );
}

/// The root widget of the application.
/// 
/// Configures the app theme, localization, and sets up the initial route.
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Get the current locale from the provider
    final localeProvider = Provider.of<LocaleProvider>(context);
    
    return MaterialApp(
      title: 'Location Search App',
      
      // Configure localization
      locale: localeProvider.locale,
      supportedLocales: const [
        Locale('en'), // English
        Locale('ar'), // Arabic
      ],
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      
      // Configure theme
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: localeProvider.isRtl ? 'Almarai' : 'Roboto',
        useMaterial3: true,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.blue,
          foregroundColor: Colors.white,
          centerTitle: true,
          elevation: 2,
        ),
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.blue,
            foregroundColor: Colors.white,
            textStyle: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
            elevation: 2,
          ),
        ),
        cardTheme: CardTheme(
          elevation: 2,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8),
          ),
        ),
        scaffoldBackgroundColor: Colors.grey.shade100,
      ),
      debugShowCheckedModeBanner: false,
      
      // Set the home screen
      home: const SearchScreen(),
    );
  }
}
