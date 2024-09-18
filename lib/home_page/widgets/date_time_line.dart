import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo_app/config/config_cubit.dart';
import 'package:todo_app/utils/app_colors.dart';

class DateTimeLine extends StatefulWidget {
  const DateTimeLine({super.key});

  @override
  State<DateTimeLine> createState() => _DateTimeLineState();
}

class _DateTimeLineState extends State<DateTimeLine> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ConfigCubit, ConfigState>(
      builder: (context, state) {
        return EasyDateTimeLine(
          disabledDates: getDisabledDatesBeforeToday(),
          locale: ConfigCubit.language,
          initialDate: DateTime.now(),
          //disabledDates: [DateTime(2024)],
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
          },
          headerProps: EasyHeaderProps(
            //showHeader: false,
            selectedDateStyle: TextStyle(
                color: ConfigCubit.isDark()
                    ? AppColors.primaryDark
                    : AppColors.white),
            monthStyle: TextStyle(color: AppColors.white),
            showMonthPicker: true,
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: DateFormatter.monthOnly(),
          ),
          dayProps: EasyDayProps(
            todayStyle: DayStyle(
                //borderRadius: 20,
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: AppColors.gray),
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: ConfigCubit.isDark()
                        ? AppColors.black
                        : AppColors.white)),
            inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.all(Radius.circular(8)),
                    color: ConfigCubit.isDark()
                        ? AppColors.black
                        : AppColors.white)),
            dayStructure: DayStructure.dayNumDayStr,
            activeDayStyle: DayStyle(
              dayNumStyle: Theme.of(context).textTheme.titleMedium,
              //dayNumStyle: TextStyle(color: App),
              decoration: BoxDecoration(
                //color: AppColors.white,
                borderRadius: const BorderRadius.all(
                  Radius.circular(
                    8,
                  ),
                ),
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  colors: [
                    AppColors.blue,
                    ConfigCubit.isDark()
                        ? AppColors.black
                        : AppColors.primaryLight,
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }

  List<DateTime> getDisabledDatesBeforeToday() {
    DateTime today = DateTime.now();

    // We will assume you want to disable all dates starting from a given year (e.g., from year 2000).
    DateTime startDate =
        DateTime(2000, 1, 1); // Example start date: January 1, 2000

    // Create a list to hold all the disabled dates
    List<DateTime> disabledDates = [];

    // Iterate from the day before today backwards to the start date
    for (DateTime date = today.subtract(Duration(days: 1));
        date.isAfter(startDate) || date.isAtSameMomentAs(startDate);
        date = date.subtract(Duration(days: 1))) {
      disabledDates.add(date);
    }

    return disabledDates;
  }
}
