import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/home_page/tabs/settings/settings_tab.dart';
import 'package:todo_app/home_page/tabs/tasks/tasks_tab.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/firebase_utils.dart';
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
  late ConfigProvider configProvider;
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      configProvider.selectedTime = TimeOfDay.now().format(context);
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);

    return Scaffold(
      //bottomSheet: BottomSheet(),
      //backgroundColor: AppColors.primaryLight,
      appBar: AppBar(
        actions: [
          IconButton(
            onPressed: () {
              FireBaseUtils.signOut(context, configProvider);
            },
            icon: Icon(Icons.logout),
          ),
        ],
        //toolbarHeight: MediaQuery.of(context).size.height * .1,
        backgroundColor: AppColors.blue,
        title: Padding(
          padding: const EdgeInsets.only(top: 32.0, left: 24),
          child: Text(
            isSelected == 1
                ? AppLocalizations.of(context)!.toDoList
                : AppLocalizations.of(context)!.settings,
            style: GoogleFonts.poppins(
              textStyle: configProvider.isDark()
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
      floatingActionButton: CustomFloatingActionButton(),
      body: tabs[isSelected],
      bottomNavigationBar: BottomAppBar(
        notchMargin: 10,
        shape: const CircularNotchedRectangle(),
        color: configProvider.isDark() ? AppColors.darkGray : AppColors.white,
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
