import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
//import 'package:todo_app/tabs/settings/drop_down_language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/home_page/tabs/settings/drop_down_theme.dart';
import 'package:todo_app/utils/app_colors.dart';

class SettingsTab extends StatefulWidget {
  const SettingsTab({super.key});

  @override
  State<SettingsTab> createState() => _SettingsTabState();
}

class _SettingsTabState extends State<SettingsTab> {
  late  ConfigProvider configProvider;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Consumer<ConfigProvider>(
      builder: (context, configProvider, _) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              //decoration: BoxDecoration(),
              height: MediaQuery.of(context).size.height * .13,
              color: AppColors.blue,
            ),
            /* Padding(
              padding: EdgeInsetsDirectional.only(
                  bottom: 20,
                  top: 20,
                  start: MediaQuery.of(context).size.width * .08),
              child: Text(
                AppLocalizations.of(context)!.language,
                //AppLocalizations.of(context)!.language,
                style: GoogleFonts.poppins(
                    textStyle: ConfigCubit.isDark()
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.white)
                        : Theme.of(context).textTheme.bodyLarge),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .1),
    
              //width: double.infinity,
              height: MediaQuery.of(context).size.height * .05,
              child: const DropDownLanguage(),
            ),*/
            Padding(
              padding: EdgeInsetsDirectional.only(
                  bottom: 20,
                  top: 20,
                  start: MediaQuery.of(context).size.width * .08),
              child: Text(
                AppLocalizations.of(context)!.mode,
                //AppLocalizations.of(context)!.language,
                style: GoogleFonts.poppins(
                    textStyle: configProvider.isDark()
                        ? Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(color: AppColors.white)
                        : Theme.of(context).textTheme.bodyLarge),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  horizontal: MediaQuery.of(context).size.width * .1),

              //width: double.infinity,
              height: MediaQuery.of(context).size.height * .05,
              child: const DropDownTheme(),
            ),
          ],
        );
      },
    );
  }
}
