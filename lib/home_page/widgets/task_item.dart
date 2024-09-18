import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_app/config/config_cubit.dart';
import 'package:todo_app/tabs/tasks/edite_task_page.dart';

import '../../utils/app_colors.dart';

class TaskItem extends StatelessWidget {
  const TaskItem({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        Navigator.pushNamed(context, EditeTaskPage.name);
      },
      child: Container(
        margin: const EdgeInsets.only(bottom: 25),
        child: Slidable(
          // The start action pane is the one at the left or the top side.
          startActionPane: ActionPane(
            extentRatio: .25,
            // A motion is a widget used to control how the pane animates.
            motion: const ScrollMotion(),

            // A pane can dismiss the Slidable.
            //dismissible: DismissiblePane(onDismissed: () {}),

            // All actions are defined in the children parameter.
            children: [
              // A SlidableAction can have an icon and/or a label.
              SlidableAction(
                borderRadius: BorderRadius.circular(20),
                onPressed: (context) {},
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
                color: ConfigCubit.isDark()
                    ? AppColors.darkGray
                    : AppColors.white),
            child: Row(
              //mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  margin: const EdgeInsets.only(
                      top: 24, bottom: 24, left: 16, right: 24),
                  color: AppColors.blue,
                  width: 5,
                  height: MediaQuery.of(context).size.height * .08,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Playbasketball',
                      textAlign: TextAlign.start,
                    ),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * .6,
                      child: Text(
                        'Playbasketball Playbasketball Playbasketball Playbasketball Playbasketball Playbasketball  Playbasketball',
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
                          backgroundColor: AppColors.blue,
                        ),
                        onPressed: () {},
                        child: Icon(
                          // opticalSize: 50,
                          Icons.check_outlined,
                          color: AppColors.white,
                          size: 30,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(top: 8.0, right: 16),
                      child: const Text('10.30 AM', textAlign: TextAlign.end),
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
