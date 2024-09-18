import 'package:flutter/material.dart';
import 'package:todo_app/config/config_cubit.dart';
import 'package:todo_app/utils/app_colors.dart';

import 'custom_bottom_sheet.dart';

class CustomFloatingActionButton extends StatelessWidget {
  const CustomFloatingActionButton({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      shape: CircleBorder(
        side: BorderSide(
          color: ConfigCubit.isDark() ? AppColors.darkGray2 : AppColors.white,
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
                  child: const CustomBottomSheet());
            });
      },
    );
  }
}
