import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:todo_app/home_page/widgets/custom_bottom_sheet.dart';

import '../../utils/app_colors.dart';

class EditeTaskPage extends StatelessWidget {
  const EditeTaskPage({super.key});
  static const String name = 'EditeTaskPage';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primaryLight,
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * .15,
        iconTheme: const IconThemeData(
          color: AppColors.white, //change your color here
        ),
        backgroundColor: AppColors.blue,
        title: Padding(
          padding: const EdgeInsets.only(left: 24),
          child: Text(
            'To Do List',
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
                    color: const Color.fromARGB(241, 255, 255, 255),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Text(
                          textAlign: TextAlign.center,
                          'Edite Task',
                          style: GoogleFonts.poppins(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleMedium!
                                .copyWith(fontWeight: FontWeight.bold),
                          ),
                        ),
                        TextField(
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.inter(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Color(0xffA9A9A9)),
                              ),
                              hintText: 'enter your task title'),
                        ),
                        TextField(
                          maxLines: 4,
                          decoration: InputDecoration(
                              hintStyle: GoogleFonts.inter(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(color: Color(0xffA9A9A9)),
                              ),
                              hintText: 'enter your task description'),
                        ),
                        InkWell(
                          onTap: () {},
                          child: Text(
                            'Select time',
                            textAlign: TextAlign.start,
                            style: GoogleFonts.inter(
                                textStyle: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(
                                        //color: Color(0xffA9A9A9),
                                        )),
                          ),
                        ),
                        Text(
                          textAlign: TextAlign.center,
                          '27-6-2021',
                          style: GoogleFonts.inter(
                            textStyle: Theme.of(context)
                                .textTheme
                                .titleSmall!
                                .copyWith(color: Color(0xffA9A9A9)),
                          ),
                        ),
                        //Spacer(),
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.blue),
                          onPressed: () {},
                          child: Text(
                            'addTask',
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
              ],
            ),
          ],
        ),
      ),
    );
  }
}
