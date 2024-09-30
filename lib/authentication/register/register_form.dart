import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/widgets/custom_auth_text_filed.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';

class RegisterForm extends StatefulWidget {
  const RegisterForm({
    super.key,
    required this.onPressed,
  });
  final VoidCallback onPressed;
  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  GlobalKey<FormState> formKey = GlobalKey<FormState>();

  TextEditingController userNameController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController confirmPasswordController = TextEditingController();

  late ConfigProvider configProvider;

  @override
  Widget build(BuildContext context) {
    configProvider = Provider.of<ConfigProvider>(context);
    return Column(
      // mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(
          margin: EdgeInsets.symmetric(
              horizontal: 16,
              vertical: MediaQuery.of(context).size.height * .05),
          width: MediaQuery.of(context).size.width * .8,
          height: MediaQuery.of(context).size.height * .6,
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
                    //textAlign: TextAlign.center,
                    'Register',
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
                    labelText: 'User name',
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'User name can not be empty';
                      }
                      return null;
                    },
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
                        return 'User name can not be empty';
                      }
                      if (value.length < 6) {
                        return 'Password can not be less than 6 characters';
                      }
                      return null;
                    },
                  ),

                  CustomAuthTextFiled(
                    labelText: 'Confirm Password',
                    controller: confirmPasswordController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return 'User name can not be empty';
                      }
                      if (value.length < 6) {
                        return 'Password can not be less than 6 characters';
                      }
                      if (value != passwordController.text) {
                        return 'Confirm password not match password';
                      }
                      return null;
                    },
                  ),

                  //Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue),
                    onPressed: () {
                      formKey.currentState!.validate();
                    },
                    child: Text(
                      'Register',
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
                      const Text('Already have an account ?'),
                      TextButton(
                        onPressed: widget.onPressed,
                        child: Text(
                          'Login',
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
