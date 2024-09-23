import 'package:easy_date_timeline/easy_date_timeline.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/provider_list.dart';
import 'package:todo_app/utils/app_colors.dart';

class DateTimeLine extends StatefulWidget {
  const DateTimeLine({super.key});

  @override
  State<DateTimeLine> createState() => _DateTimeLineState();
}

class _DateTimeLineState extends State<DateTimeLine> {
  late ConfigProvider configProvider;
  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    
        return EasyDateTimeLine(
          disabledDates: ConfigProvider.getDisabledDatesBeforeToday(),
          locale: configProvider.language,
          initialDate: DateTime.now(),
          //disabledDates: [DateTime(2024)],
          onDateChange: (selectedDate) {
            //`selectedDate` the new date selected.
          },
          headerProps: EasyHeaderProps(
            //showHeader: false,
            selectedDateStyle: TextStyle(
                color: configProvider.isDark()
                    ? AppColors.primaryDark
                    : AppColors.white),
            monthStyle: const TextStyle(color: AppColors.white),
            showMonthPicker: true,
            monthPickerType: MonthPickerType.switcher,
            dateFormatter: const DateFormatter.monthOnly(),
          ),
          dayProps: EasyDayProps(
            todayStyle: DayStyle(
                //borderRadius: 20,
                decoration: BoxDecoration(
                    border: Border.all(width: 3, color: AppColors.gray),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                    color: configProvider.isDark()
                        ? AppColors.black
                        : AppColors.white)),
            inactiveDayStyle: DayStyle(
                decoration: BoxDecoration(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(
                        8,
                      ),
                    ),
                    color: configProvider.isDark()
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
                    configProvider.isDark()
                        ? AppColors.black
                        : AppColors.primaryLight,
                  ],
                ),
              ),
            ),
          ),
        );
     
  }
}
