import 'package:flutter/material.dart';
import 'package:todo_app/home_page/widgets/date_time_line.dart';
import 'package:todo_app/utils/app_colors.dart';

import '../../home_page/widgets/task_item.dart';

class TasksTab extends StatelessWidget {
  const TasksTab({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Stack(
          children: [
            Container(
              //decoration: BoxDecoration(),
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
                itemCount: 10,
                itemBuilder: (context, index) {
                  return TaskItem();
                }),
          ),
        )
      ],
    );
  }
}
