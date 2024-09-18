import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/config/config_cubit.dart';
//import 'package:todo_app/tabs/settings/drop_down_language.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:todo_app/tabs/settings/drop_down_theme.dart';
import 'package:todo_app/utils/app_colors.dart';

class SettingsTab extends StatelessWidget {
  const SettingsTab({super.key});

  @override
  Widget build(BuildContext context) {
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
          child: const DropDownTheme(),
        ),
      ],
    );
  }
}
