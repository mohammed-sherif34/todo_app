import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';

import 'custom_bottom_sheet.dart';

// ignore: must_be_immutable
class CustomFloatingActionButton extends StatelessWidget {
  CustomFloatingActionButton({
    super.key,
  });
  late ConfigProvider configProvider;
  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
   
        return FloatingActionButton(
          shape: CircleBorder(
            side: BorderSide(
              color: configProvider.isDark()
                  ? AppColors.darkGray2
                  : AppColors.white,
              width: 4,
            ),
          ),
          backgroundColor: AppColors.blue,
          child: const Icon(
            Icons.add,
            size: 20,
            color: AppColors.white,
          ),
          onPressed: () {
            showModalBottomSheet(
              isScrollControlled: true,
              context: context,
              builder: (context) {
                return Container(
                  padding: EdgeInsets.only(
                      bottom: MediaQuery.of(context).viewInsets.bottom),
                  child: const CustomBottomSheet(),
                );
              },
            );
          },
        );
     
  }
}
