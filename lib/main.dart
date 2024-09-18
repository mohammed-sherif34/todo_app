import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:todo_app/config/config_cubit.dart';
import 'package:todo_app/tabs/tasks/edite_task_page.dart';
import 'package:todo_app/utils/my_theme_data.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'home_page/home_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(BlocProvider(
    create: (context) => ConfigCubit(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  MyApp({super.key});
  String appLanguage=ConfigCubit.language ;
  ThemeMode themeMode=ConfigCubit.themeMode ;
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, state) {
        if (state is ConfigChangeLanguageState) {
          appLanguage = ConfigCubit.language;
        }
        if (state is ConfigChangeThemeState) {
          themeMode = ConfigCubit.themeMode;
        }
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
          locale: Locale.fromSubtags(languageCode: appLanguage),
          themeMode: themeMode,
          theme: MyThemeData.lightTheme,
          darkTheme: MyThemeData.darkTheme,
          debugShowCheckedModeBanner: false,
          routes: {
            EditeTaskPage.name: (context) => const EditeTaskPage(),
            HomePage.name: (context) => const HomePage(),
          },
          initialRoute: HomePage.name,
        );
      },
    );
  }
}
