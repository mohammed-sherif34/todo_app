import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/home_page/tabs/tasks/edite_task_page.dart';
import 'package:todo_app/utils/firebase_utils.dart';

import '../../utils/app_colors.dart';

// ignore: must_be_immutable
class TaskItem extends StatefulWidget {
  TaskItem({
    super.key,
    required this.task,
  });
  late Task task;

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
        margin: const EdgeInsets.only(
          bottom: 25,
          right: 16,
          left: 16,
        ),
        child: Slidable(
          startActionPane: ActionPane(
            extentRatio: .25,
            motion: const ScrollMotion(),
            children: [
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                onPressed: (context) {
                  FireBaseUtils.deleteTask(widget.task, context);
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
              children: [
                Container(
                  margin: const EdgeInsetsDirectional.only(
                      top: 24, bottom: 24, start: 16, end: 24),
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
                      style: Theme.of(context).textTheme.titleSmall!.copyWith(
                            color: widget.task.isDone
                                ? AppColors.green
                                : AppColors.blue,
                          ),
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .5,
                      child: Padding(
                        padding: const EdgeInsetsDirectional.only(start: 8.0),
                        child: Text(
                          widget.task.description,
                          style:
                              Theme.of(context).textTheme.bodyLarge!.copyWith(
                                    color: widget.task.isDone
                                        ? AppColors.green
                                        : AppColors.blue,
                                  ),
                          textAlign: TextAlign.start,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Column(
                  children: [
                    Padding(
                      padding: const EdgeInsetsDirectional.only(end: 16.0),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: widget.task.isDone
                              ? AppColors.green
                              : AppColors.blue,
                        ),
                        onPressed: () {
                          if (!widget.task.isDone) {
                            widget.task = Task(
                                time: widget.task.time,
                                id: widget.task.id,
                                title: widget.task.title,
                                description: widget.task.description,
                                date: widget.task.date,
                                isDone: true);
                            FireBaseUtils.updateTask(
                              configProvider: configProvider,
                              context: context,
                              task: widget.task,
                            );
                          }
                          configProvider.gettasksList();
                        },
                        child: const Icon(
                          Icons.check_outlined,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding:
                          const EdgeInsetsDirectional.only(top: 8.0, end: 16),
                      child: Text(configProvider.selectedTime,
                          style: Theme.of(context)
                              .textTheme
                              .bodySmall!
                              .copyWith(
                                  color: configProvider.isDark()
                                      ? AppColors.gray
                                      : AppColors.black),
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
