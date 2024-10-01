import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/widgets/custom_auth_text_filed.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/firebase_utils.dart';

class LoginForm extends StatefulWidget {
  const LoginForm({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  State<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends State<LoginForm> {
  late ConfigProvider configProvider;
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController emailController = TextEditingController(
    text: 'mohamed@gmail.com',
  );

  TextEditingController passwordController = TextEditingController(
    text: '123456',
  );
  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: MediaQuery.of(context).size.height * .1),
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .5,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30),
            color: configProvider.isDark()
                ? AppColors.darkGray
                : const Color.fromARGB(241, 255, 255, 255),
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    textAlign: TextAlign.center,
                    'Welcome back !',
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                              color: configProvider.isDark()
                                  ? AppColors.gray
                                  : AppColors.black,
                              fontWeight: FontWeight.bold),
                    ),
                  ),
                  Text(
                    textAlign: TextAlign.start,
                    'Login',
                    style: GoogleFonts.poppins(
                      textStyle: Theme.of(context)
                          .textTheme
                          .titleLarge!
                          .copyWith(
                              color: configProvider.isDark()
                                  ? AppColors.gray
                                  : AppColors.black,
                              fontWeight: FontWeight.bold),
                    ),
                  ),

                  CustomAuthTextFiled(
                    labelText: 'Email',
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Email can not be empty';
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return 'please enter a valid email';
                      }
                      return null;
                    },
                  ),
                  CustomAuthTextFiled(
                    labelText: 'Password',
                    controller: passwordController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'Password can not be empty';
                      }
                      if (value.length < 6) {
                        return 'Password can not be less than 6 characters';
                      }
                      return null;
                    },
                  ),

                  //Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue),
                    onPressed: () {
                      FireBaseUtils.login(
                          formKey: formKey,
                          emailController: emailController,
                          passwordController: passwordController);
                    },
                    child: Text(
                      'Login',
                      style: GoogleFonts.poppins(
                        textStyle: Theme.of(context)
                            .textTheme
                            .titleMedium!
                            .copyWith(color: AppColors.white),
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      const Text('Don\'t have an account ?'),
                      TextButton(
                        onPressed: widget.onPressed,
                        child: Text(
                          'Register',
                          style: Theme.of(context).textTheme.titleSmall,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    );
  }
}
