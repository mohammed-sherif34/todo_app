import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/firebase_utils.dart';
import 'package:todo_app/utils/snackbar_utils.dart';
import '../../../utils/app_colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EditeTaskPage extends StatefulWidget {
  const EditeTaskPage({super.key});
  static const String name = 'EditeTaskPage';

  @override
  State<EditeTaskPage> createState() => _EditeTaskPageState();
}

class _EditeTaskPageState extends State<EditeTaskPage> {
  late ConfigProvider configProvider;
  late Task task;
  TextEditingController editingTilteController = TextEditingController();
  TextEditingController editingDescController = TextEditingController();
  final GlobalKey<FormState> editeFormKey = GlobalKey<FormState>();
  @override
  /*
  void dispose() {
    editingDescController.dispose();
    editingTilteController.dispose();
    super.dispose();
  }
*/
  @override
  void initState() {
    WidgetsBinding.instance.addPostFrameCallback((duration) {
      task = ModalRoute.of(context)!.settings.arguments as Task;
      configProvider.selectDate = task.date;
      configProvider.selectedTime = task.time;
      editingDescController.text = task.description;
      editingTilteController.text = task.title;
      setState(() {});
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Scaffold(
      backgroundColor: configProvider.isDark()
          ? AppColors.primaryDark
          : AppColors.primaryLight,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        iconTheme: IconThemeData(
          color: configProvider.isDark()
              ? AppColors.primaryDark
              : AppColors.white, //change your color here
        ),
        backgroundColor: AppColors.blue,
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            AppLocalizations.of(context)!.toDoList,
            style: GoogleFonts.poppins(
              textStyle: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              alignment: AlignmentDirectional.topCenter,
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .06,
                  color: AppColors.blue,
                ),
                Container(
                  width: MediaQuery.of(context).size.width * .9,
                  height: MediaQuery.of(context).size.height * .6,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: configProvider.isDark()
                        ? AppColors.darkGray
                        : const Color.fromARGB(241, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Form(
                      key: editeFormKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Text(
                            textAlign: TextAlign.center,
                            AppLocalizations.of(context)!.editeTask,
                            style: GoogleFonts.poppins(
                              textStyle: Theme.of(context)
                                  .textTheme
                                  .titleMedium!
                                  .copyWith(
                                      color: configProvider.isDark()
                                          ? AppColors.gray
                                          : AppColors.black,
                                      fontWeight: FontWeight.bold),
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: configProvider.isDark()
                                    ? AppColors.gray
                                    : AppColors.black),
                            controller: editingTilteController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .titleCanNotbeEmpty;
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
                              //hintText: 'enter your task title'
                            ),
                          ),
                          TextFormField(
                            style: TextStyle(
                                color: configProvider.isDark()
                                    ? AppColors.gray
                                    : AppColors.black),
                            controller: editingDescController,
                            validator: (value) {
                              if (value == null || value.isEmpty) {
                                return AppLocalizations.of(context)!
                                    .descCanNotbeEmpty;
                              }
                              return null;
                            },
                            maxLines: 4,
                            decoration: InputDecoration(
                              hintStyle: GoogleFonts.inter(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: const Color(0xffA9A9A9)),
                              ),
                              //label: Text('desc')
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              InkWell(
                                onTap: () {
                                  configProvider.showCalender(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.selectdate,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                      textStyle: configProvider.isDark()
                                          ? Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.gray)
                                          : Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  configProvider.selectTime(context);
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.selectTime,
                                  textAlign: TextAlign.start,
                                  style: GoogleFonts.inter(
                                      textStyle: configProvider.isDark()
                                          ? Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: AppColors.gray)
                                          : Theme.of(context)
                                              .textTheme
                                              .titleSmall),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Text(
                                textAlign: TextAlign.center,
                                configProvider.formateDate(
                                    date: configProvider.selectDate),
                                style: GoogleFonts.inter(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: const Color(0xffA9A9A9)),
                                ),
                              ),
                              Text(
                                textAlign: TextAlign.center,
                                configProvider.selectedTime,
                                style: GoogleFonts.inter(
                                  textStyle: Theme.of(context)
                                      .textTheme
                                      .titleSmall!
                                      .copyWith(color: const Color(0xffA9A9A9)),
                                ),
                              ),
                            ],
                          ),
                          //Spacer(),
                          ElevatedButton(
                            style: ElevatedButton.styleFrom(
                                backgroundColor: AppColors.blue),
                            onPressed: () async {
                              if (editeFormKey.currentState!.validate()) {
                                task = Task(
                                    time: task.time,
                                    id: task.id,
                                    title: editingTilteController.text,
                                    description: editingDescController.text,
                                    date: configProvider.selectDate);
                                String msg = await FireBaseUtils.updateTask(
                                  configProvider: configProvider,
                                  context: context,
                                  task: task,
                                );
                                SnackBarUtils.showSnackBar(
                                    // ignore: use_build_context_synchronously
                                    context: context,
                                    text: msg,
                                    configProvider: configProvider);
                                // ignore: use_build_context_synchronously
                                Navigator.pop(context);
                              }
                            },
                            child: Text(
                              AppLocalizations.of(context)!.saveChanges,
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
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
