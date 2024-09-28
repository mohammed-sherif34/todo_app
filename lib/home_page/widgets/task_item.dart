import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/home_page/tabs/tasks/edite_task_page.dart';
import 'package:todo_app/utils/firebase_utils.dart';

import '../../utils/app_colors.dart';

class TaskItem extends StatefulWidget {
  const TaskItem({
    super.key,
    required this.task,
  });
  final Task task;

  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  late ConfigProvider configProvider;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditeTaskPage.name,
            arguments: widget.task);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: .25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                onPressed: (context) {
                  FireBaseUtils.deleteTask(widget.task);
                  configProvider.gettasksList();
                },
                backgroundColor: const Color(0xFFFE4A49),
                foregroundColor: Colors.white,
                icon: Icons.delete,
                label: 'Delete',
              ),
            ],
          ),
          child: Container(
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(
                  20,
                ),
                color: configProvider.isDark()
                    ? AppColors.darkGray
                    : AppColors.white),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 24, bottom: 24, left: 16, right: 24),
                  color: widget.task.isDone ? AppColors.green : AppColors.blue,
                  width: 5,
                  height: MediaQuery.of(context).size.height * .08,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.task.title,
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        widget.task.description,
                        textAlign: TextAlign.center,
                        maxLines: 2,
                        overflow: TextOverflow.clip,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.task.isDone
                              ? AppColors.green
                              : AppColors.blue,
                        ),
                        onPressed: () {
                          if (!widget.task.isDone) {
                            FireBaseUtils.updateTask(
                                task: widget.task,
                                updatedData: Task(
                                  time: widget.task.time,
                                        id: widget.task.id,
                                        title: widget.task.title,
                                        description: widget.task.description,
                                        date: widget.task.date,
                                        isDone: true)
                                    .toJson());
                          }
                          configProvider.gettasksList();
                        },
                        child: const Icon(
                          // opticalSize: 50,
                          Icons.check_outlined,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 16),
                      child: Text(widget.task.time,
                          textAlign: TextAlign.end),
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
