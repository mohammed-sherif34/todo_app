import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:date_format/date_format.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/utils/firebase_utils.dart';

class ConfigProvider extends ChangeNotifier {
  String language = 'en';
  ThemeMode themeMode = ThemeMode.light;
  List<Task> tasksList = [];
  DateTime selectDate = DateTime.now();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descrController = TextEditingController();

  void gettasksList() async {
    QuerySnapshot<Task> querySnapshot =
        await FireBaseUtils.collectionRef().get();
    tasksList = querySnapshot.docs
        .map(
          (doc) => doc.data(),
        )
        .toList();
    notifyListeners();
  }

  void addTask(BuildContext context) {
    formKey.currentState?.validate();

    Task task = Task(
        title: titleController.text,
        description: descrController.text,
        time: selectDate);
    FireBaseUtils.addTask(task)
        .timeout(const Duration(seconds: 1), onTimeout: () {});
    gettasksList();
    Navigator.pop(context);
    titleController.clear();
    descrController.clear();
  }

  String formateDate() {
    return formatDate(selectDate, [dd, '-', mm, '-', yyyy]);
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
