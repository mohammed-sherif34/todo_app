import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/provider_list.dart';
import 'package:todo_app/utils/app_colors.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  late ConfigProvider configProvider;
  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return BottomSheet(
      backgroundColor:
          configProvider.isDark() ? AppColors.primaryDark : AppColors.white,
      //dragHandleSize: Size.square(200),
      onClosing: () {},
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
          ),
          height: MediaQuery.of(context).size.height * .55,
          child: Form(
            key: configProvider.formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  textAlign: TextAlign.center,
                  'Add new Task',
                  style: GoogleFonts.poppins(
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(
                            color: configProvider.isDark()
                                ? AppColors.gray
                                : AppColors.darkGray,
                            fontWeight: FontWeight.bold),
                  ),
                ),
                TextFormField(
                  controller: configProvider.titleController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'title can not be empty';
                    }
                    return null;
                  },
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.inter(
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: const Color(0xffA9A9A9)),
                      ),
                      hintText: 'enter your task title'),
                ),
                TextFormField(
                  controller: configProvider.descrController,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'description can not be empty';
                    }
                    return null;
                  },
                  maxLines: 2,
                  decoration: InputDecoration(
                      hintStyle: GoogleFonts.inter(
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleSmall!
                            .copyWith(color: const Color(0xffA9A9A9)),
                      ),
                      //label: Text('description'),
                      hintText: 'enter your task description'),
                ),
                InkWell(
                  onTap: () {
                    configProvider.showCalender(context);
                  },
                  child: Text(
                    'Select time',
                    textAlign: TextAlign.start,
                    style: GoogleFonts.inter(
                        textStyle: configProvider.isDark()
                            ? Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: AppColors.gray)
                            : Theme.of(context).textTheme.titleSmall),
                  ),
                ),
                Text(
                  textAlign: TextAlign.center,
                  configProvider.formateDate(),
                  style: GoogleFonts.inter(
                    textStyle: Theme.of(context)
                        .textTheme
                        .titleSmall!
                        .copyWith(color: const Color(0xffA9A9A9)),
                  ),
                ),
                //Spacer(),
                ElevatedButton(
                  style:
                      ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                  onPressed: () {
                    configProvider.addTask(context);
                  },
                  child: Text(
                    'addTask',
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleMedium!
                          .copyWith(color: AppColors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
