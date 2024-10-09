import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/auth_page.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/home_page/tabs/tasks/edite_task_page.dart';
import 'package:todo_app/utils/my_theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(ChangeNotifierProvider(
    create: (context) => ConfigProvider(),
    child: const TodoApp(),
  ));
}

class TodoApp extends StatelessWidget {
  const TodoApp({super.key});

  @override
  Widget build(BuildContext context) {
    ConfigProvider configProvider = Provider.of<ConfigProvider>(context);
    
   
    
    return Consumer<ConfigProvider>(
      builder: (context, state, _) {
        return MaterialApp(
          localizationsDelegates: const [
            AppLocalizations.delegate, // Add this line
            GlobalMaterialLocalizations.delegate,
            GlobalWidgetsLocalizations.delegate,
            GlobalCupertinoLocalizations.delegate,
          ],
          supportedLocales: const [
            Locale('en'), // English
            Locale('ar'),
          ],
          locale: Locale.fromSubtags(languageCode: configProvider.language),
          themeMode: configProvider.themeMode,
          theme: MyThemeData.lightTheme,
          darkTheme: MyThemeData.darkTheme,
          debugShowCheckedModeBanner: false,
          routes: {
            EditeTaskPage.name: (context) => const EditeTaskPage(),
            HomePage.name: (context) => const HomePage(),
            AuthPage.name: (context) => const AuthPage(),
          },
          initialRoute: AuthPage.name,
        );
      },
    );
  }
}
