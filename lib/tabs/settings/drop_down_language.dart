import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/config/config_cubit.dart';
import 'package:todo_app/utils/app_colors.dart';

class DropDownLanguage extends StatefulWidget {
  const DropDownLanguage({super.key});

  @override
  State<DropDownLanguage> createState() => _DropDownLanguageState();
}

class _DropDownLanguageState extends State<DropDownLanguage> {
   
  String? selectedValue;
  ConfigCubit viewModel = ConfigCubit();
  @override
  Widget build(BuildContext context) {
    List<String> items = [
    'English',
    'العربية',
  ];
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, state) {
        String selectedValue =
            ConfigCubit.language == 'en' ? 'English' : 'العربية';
        
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
                  cubit.changeLanguage(value == 'English' ? 'en' : 'ar');
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
