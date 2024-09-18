import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/utils/app_colors.dart';

class CustomBottomSheet extends StatefulWidget {
  const CustomBottomSheet({
    super.key,
  });

  @override
  State<CustomBottomSheet> createState() => _CustomBottomSheetState();
}

class _CustomBottomSheetState extends State<CustomBottomSheet> {
  var selectDate = DateTime.now();
  @override
  Widget build(BuildContext context) {
    return BottomSheet(
      //dragHandleSize: Size.square(200),
      onClosing: () {},
      builder: (context) {
        return Container(
          margin: const EdgeInsets.only(
            left: 16,
            right: 16,
            //bottom: MediaQuery.of(context).viewInsets.bottom,
          ),
          height: MediaQuery.of(context).size.height * .55,
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
                      .copyWith(fontWeight: FontWeight.bold),
                ),
              ),
              TextField(
                decoration: InputDecoration(
                    hintStyle: GoogleFonts.inter(
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Color(0xffA9A9A9)),
                    ),
                    hintText: 'enter your task title'),
              ),
              TextField(
                maxLines: 4,
                decoration: InputDecoration(
                    hintStyle: GoogleFonts.inter(
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleSmall!
                          .copyWith(color: Color(0xffA9A9A9)),
                    ),
                    hintText: 'enter your task description'),
              ),
              InkWell(
                onTap: showCalender,
                child: Text(
                  'Select time',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.inter(
                      textStyle: Theme.of(context).textTheme.titleSmall),
                ),
              ),
              Text(
                textAlign: TextAlign.center,
                formateDate(),
                style: GoogleFonts.inter(
                  textStyle: Theme.of(context)
                      .textTheme
                      .titleSmall!
                      .copyWith(color: Color(0xffA9A9A9)),
                ),
              ),
              //Spacer(),
              ElevatedButton(
                style:
                    ElevatedButton.styleFrom(backgroundColor: AppColors.blue),
                onPressed: () {},
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
        );
      },
    );
  }

  String formateDate() {
    return formatDate(selectDate, [dd, '-', mm, '-', yyyy]);
  }

  void showCalender() async {
    var chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    selectDate = chosenDate ?? selectDate;
    setState(() {});
  }
}
