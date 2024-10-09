import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/utils/firebase_utils.dart';
import 'package:todo_app/utils/snackbar_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class ConfigProvider extends ChangeNotifier {
  bool loading = false;

  bool isLoading() {
    return loading;
  }

  void setLoading(bool value) {
    loading = value;
    notifyListeners(); // Notify listeners when loading state changes
  }

  String language = 'en';
  ThemeMode themeMode = ThemeMode.light;
  static late MyUser user;
  DateTime selectDate = DateTime.now();

  DateTime timeLineSelectedDate = DateTime.now();
  List<Task> tasksList = [];
  String selectedTime = "";

  Future<void> selectTime(BuildContext context) async {
    TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: TimeOfDay.now(),
    );
   
    if (picked != null) {
      // ignore: use_build_context_synchronously
      selectedTime = formateTime(picked, context);
      notifyListeners();
    }
  }

  String formateTime(TimeOfDay picked, context) {
    return picked.format(context);
  }

  void changeSelectDate(DateTime date) {
    timeLineSelectedDate = date;
    gettasksList();
    notifyListeners();
  }

  void gettasksList() async {
    // Get start and end of the selected day (full day range)
    DateTime startOfDay = DateTime(
      timeLineSelectedDate.year,
      timeLineSelectedDate.month,
      timeLineSelectedDate.day,
      0,
      0,
      0,
    );

    DateTime endOfDay = DateTime(
      timeLineSelectedDate.year,
      timeLineSelectedDate.month,
      timeLineSelectedDate.day,
      23,
      59,
      59,
    );

    // Convert DateTime to Firebase Timestamps for querying
    Timestamp startTimestamp = Timestamp.fromDate(startOfDay);
    Timestamp endTimestamp = Timestamp.fromDate(endOfDay);

    // Query Firestore for tasks between startOfDay and endOfDay
    QuerySnapshot<Task> querySnapshot =
        await FireBaseUtils.tasksCollectionRef(user.id)
            .where('date', isGreaterThanOrEqualTo: startTimestamp)
            .where('date', isLessThanOrEqualTo: endTimestamp)
            .orderBy(
              'date',
            )
            .get();

    tasksList = querySnapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();

    notifyListeners();
  }

  void addTask(
      {required context,
      required GlobalKey<FormState> formKey,
      required TextEditingController titleController,
      required TextEditingController descrController}) {
    if (formKey.currentState!.validate()) {
      Task task = Task(
          time: selectedTime,
          title: titleController.text,
          description: descrController.text,
          date: selectDate);
      FireBaseUtils.addTask(task)
          .timeout(const Duration(seconds: 1), onTimeout: () {});
      SnackBarUtils.showSnackBar(
          configProvider: ConfigProvider(),
          context: context,
          text: AppLocalizations.of(context)!.taskAddedSuccessfuly);
      gettasksList();
      Navigator.pop(context);
      titleController.clear();
      descrController.clear();
    }
  }

  String formateDate({required DateTime date}) {
    return formatDate(date, [dd, '-', mm, '-', yyyy]);
  }

  void showCalender(context) async {
    var chosenDate = await showDatePicker(
      context: context,
      firstDate: DateTime.now(),
      lastDate: DateTime.now().add(
        const Duration(days: 365),
      ),
    );

    selectDate = chosenDate ?? selectDate;
    //formateDate(date: selectDate);
    notifyListeners();
  }

  void changeLanguage(String newLanguage) {
    if (language == newLanguage) return;
    language = newLanguage;

    notifyListeners();
  }

  void changeTheme(ThemeMode newTheme) {
    if (themeMode == newTheme) return;
    themeMode = newTheme;

    notifyListeners();
  }

  bool isDark() {
    return themeMode == ThemeMode.dark;
  }

  static List<DateTime> getDisabledDatesBeforeToday() {
    DateTime today = DateTime.now();

    // We will assume you want to disable all dates starting from a given year (e.g., from year 2000).
    DateTime startDate = DateTime(
        DateTime.now().year, 1, 1); // Example start date: January 1, 2000

    // Create a list to hold all the disabled dates
    List<DateTime> disabledDates = [];

    // Iterate from the day before today backwards to the start date
    for (DateTime date = today.subtract(const Duration(days: 1));
        date.isAfter(startDate) || date.isAtSameMomentAs(startDate);
        date = date.subtract(const Duration(days: 1))) {
      disabledDates.add(date);
    }

    return disabledDates;
  }
}
