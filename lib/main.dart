import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:remindme/firebase_options.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'core/classes/theme_controller.dart';
import 'core/routes/app_screens.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await GetStorage.init('Storage');

  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('fr', 'FR'), // Français
        // Ajoutez d'autres locales ici si nécessaire
      ],
      theme: ThemeController().customTheme,
      locale: const Locale('fr', 'FR'),
      debugShowCheckedModeBanner: false,
      title: 'RemindMe',
      initialRoute: AppScreens.initial,
      getPages: AppScreens.routes,
      defaultTransition: Transition.fadeIn,
    );
  }
}
