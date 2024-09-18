import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/config/config_cubit.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class DropDownTheme extends StatefulWidget {
  const DropDownTheme({super.key});

  @override
  State<DropDownTheme> createState() => _DropDownThemeState();
}

class _DropDownThemeState extends State<DropDownTheme> {
  late List<String> items;
  String? selectedValue;
  late String light;
  late String dark;
  ConfigCubit viewModel = ConfigCubit();
  @override
  Widget build(BuildContext context) {
    light = AppLocalizations.of(context)!.light;
    dark = AppLocalizations.of(context)!.dark;
    items = [light, dark];
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, state) {
        String selectedValue =
            ConfigCubit.themeMode == ThemeMode.light ? light : dark;
        //if (ConfigCubit.language == 'en') {}
        return Scaffold(
          body: DropdownButtonHideUnderline(
            child: DropdownButton2<String>(
              iconStyleData: IconStyleData(iconEnabledColor: AppColors.blue),
              isExpanded: true,
              hint: Text(
                selectedValue,
                style: const TextStyle(
                  fontSize: 14,
                  color: AppColors.white,
                ),
              ),
              items: items
                  .map((String item) => DropdownMenuItem<String>(
                        value: item,
                        child: Text(
                          item,
                          style: const TextStyle(
                              fontSize: 14, color: AppColors.blue),
                        ),
                      ))
                  .toList(),
              value: selectedValue,
              onChanged: (String? value) {
                if (value != null) {
                  ConfigCubit cubit = context.read<ConfigCubit>();
                  cubit.changeTheme(
                      value == light ? ThemeMode.light : ThemeMode.dark);
                }
              },
              buttonStyleData: ButtonStyleData(
                decoration: BoxDecoration(
                    color: ConfigCubit.isDark()
                        ? AppColors.darkGray
                        : AppColors.white,
                    border: Border.all(color: AppColors.blue)),
              ),
              menuItemStyleData: const MenuItemStyleData(
                height: 40,
              ),
            ),
          ),
        );
      },
    );
  }
}
