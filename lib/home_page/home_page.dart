import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/config/config_cubit.dart';
import 'package:todo_app/home_page/widgets/date_time_line.dart';
import 'package:todo_app/tabs/settings/settings_tab.dart';
import 'package:todo_app/tabs/tasks/tasks_tab.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'widgets/custom_floating_action_button.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});
  static const String name = 'HomePage';
  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int isSelected = 1;
  Color menuColor = AppColors.gray;
  Color settingColor = AppColors.gray;
  List<Widget> tabs = [const SettingsTab(), const TasksTab()];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //bottomSheet: BottomSheet(),
      //backgroundColor: AppColors.primaryLight,
      appBar: AppBar(
        //toolbarHeight: MediaQuery.of(context).size.height * .1,
        backgroundColor: AppColors.blue,
        title: Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 24),
          child: Text(
            isSelected == 1
                ? AppLocalizations.of(context)!.toDoList
                : AppLocalizations.of(context)!.settings,
            style: GoogleFonts.poppins(
              textStyle: ConfigCubit.isDark()
                  ? Theme.of(context)
                      .textTheme
                      .titleLarge!
                      .copyWith(color: AppColors.primaryDark)
                  : Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),

      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: const CustomFloatingActionButton(),
      body: tabs[isSelected],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        color: ConfigCubit.isDark() ? AppColors.darkGray : AppColors.white,
        child: Row(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            const Spacer(),
            IconButton(
              icon: const Icon(
                Icons.menu,
                size: 33,
              ),
              color: menuColor,
              onPressed: () {
                menuColor = AppColors.blue;
                settingColor = AppColors.gray;
                isSelected = 1;
                setState(() {});
              },
            ),
            const Spacer(
              flex: 4,
            ),
            IconButton(
              icon: const Icon(
                Icons.settings,
                size: 33,
              ),
              color: settingColor,
              onPressed: () {
                menuColor = AppColors.gray;
                settingColor = AppColors.blue;
                isSelected = 0;

                setState(() {});
              },
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
