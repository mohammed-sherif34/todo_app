import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';

class CustomAuthTextFiled extends StatefulWidget {
   const CustomAuthTextFiled({
    super.key,
    required this.labelText,
    this.validator,
    this.controller,
    this.obscureText=false,
  });

  final String labelText;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
   final bool obscureText ;

  @override
  State<CustomAuthTextFiled> createState() => _CustomAuthTextFiledState();
}

class _CustomAuthTextFiledState extends State<CustomAuthTextFiled> {
  late ConfigProvider configProvider;
  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: TextFormField(
        //enabled: enabled,
        obscureText: widget.obscureText,
        //enabled: false,
        controller: widget.controller,
        style: TextStyle(
            color: configProvider.isDark() ? AppColors.gray : AppColors.black),
        validator: widget.validator,
        decoration: InputDecoration(
          focusedBorder: OutlineInputBorder(
            borderSide: const BorderSide(
                style: BorderStyle.solid, width: 2, color: AppColors.blue),
            borderRadius: BorderRadius.circular(20),
          ),

          border: OutlineInputBorder(
            borderSide: const BorderSide(width: 2, color: AppColors.blue),
            borderRadius: BorderRadius.circular(20),
          ),
          label: Text(widget.labelText),
          hintStyle: GoogleFonts.inter(
            textStyle: Theme.of(context)
                .textTheme
                .titleSmall!
                .copyWith(color: const Color(0xffA9A9A9)),
          ),
          //hintText: 'enter your task title'
        ),
      ),
    );
  }
}
