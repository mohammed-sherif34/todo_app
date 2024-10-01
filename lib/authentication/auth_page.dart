import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/login/login_form.dart';
import 'package:todo_app/authentication/register/register_form.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});
  static const name = 'AuthPage';
  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  late ConfigProvider configProvider;
  bool isLogin = true;
  void changeAuthForm() {
    isLogin = !isLogin;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Scaffold(
      appBar: AppBar(
        //elevation: 0,
        toolbarHeight: MediaQuery.of(context).size.height * .17,
        iconTheme: IconThemeData(
          color: configProvider.isDark()
              ? AppColors.primaryDark
              : AppColors.white, //change your color here
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
          child: isLogin
              ? LoginForm(
                  onPressed: changeAuthForm,
                )
              : RegisterForm(
                  onPressed: changeAuthForm,
                )),
    );
  }
}
