import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/home_page/widgets/date_time_line.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';

import '../../widgets/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
  
    var configProvider = Provider.of<ConfigProvider>(context);
    if (configProvider.tasksList.isEmpty) {
  configProvider.gettasksList();
}
    return Column(
      children: [
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height * .13,
              color: AppColors.blue,
            ),
            const Padding(
              padding: EdgeInsets.only(top: 10.0),
              child: DateTimeLine(),
            ),
          ],
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: ListView.builder(
              itemCount: configProvider.tasksList.length,
              itemBuilder: (context, index) {
                return TaskItem(
                  task: configProvider.tasksList[index],
                );
              },
            ),
          ),
        )
      ],
    );
  }
}
