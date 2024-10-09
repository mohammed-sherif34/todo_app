import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/widgets/custom_auth_text_filed.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
                    AppLocalizations.of(context)!.register,
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
                    labelText: AppLocalizations.of(context)!.userName,
                    controller: userNameController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .userNameCanNotBeEmpty;
                      }
                      return null;
                    },
                  ),
                  CustomAuthTextFiled(
                    labelText: AppLocalizations.of(context)!.email,
                    controller: emailController,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!.emailCanNotbeEmpty;
                      }
                      final bool emailValid = RegExp(
                              r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                          .hasMatch(value);
                      if (!emailValid) {
                        return AppLocalizations.of(context)!
                            .pleasEentervalidEmail;
                      }
                      return null;
                    },
                  ),
                  CustomAuthTextFiled(
                    labelText: AppLocalizations.of(context)!.password,
                    controller: passwordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .passwordCanNotBeEmpty;
                      }
                      if (value.length < 6) {
                        return AppLocalizations.of(context)!
                            .passwordCanNotBelessThan6characters;
                      }
                      return null;
                    },
                  ),
                  CustomAuthTextFiled(
                    labelText: AppLocalizations.of(context)!.confirmPassword,
                    controller: confirmPasswordController,
                    obscureText: true,
                    validator: (value) {
                      if (value == null || value.trim().isEmpty) {
                        return AppLocalizations.of(context)!
                            .confirmPasswordCanNotBeEmpty;
                      }
                      if (value.length < 6) {
                        return AppLocalizations.of(context)!
                            .passwordCanNotBelessThan6characters;
                      }
                      if (value != passwordController.text) {
                        return AppLocalizations.of(context)!
                            .confirmPasswordNotMatchPassword;
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue),
                    onPressed: () {
                      FireBaseUtils.register(
                          userNameController: userNameController,
                          configProvider: configProvider,
                          formKey: formKey,
                          emailController: emailController,
                          passwordController: passwordController,
                          context: context);
                    },
                    child: Padding(
                      padding: const EdgeInsets.symmetric(vertical: 8.0),
                      child: Consumer<ConfigProvider>(
                        builder: (context, configProvider, _) {
                          return configProvider.isLoading()
                              ? Center(
                                  child: CircularProgressIndicator(
                                    color: Theme.of(context).primaryColor,
                                  ),
                                )
                              : Text(
                                  AppLocalizations.of(context)!.register,
                                  style: GoogleFonts.poppins(
                                    textStyle: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: AppColors.white),
                                  ),
                                );
                        },
                      ),
                    ),
                  ),
                  Row(
                    children: [
                      Text(AppLocalizations.of(context)!.alreadyHaveAnAccount),
                      TextButton(
                        onPressed: widget.onPressed,
                        child: Text(
                          AppLocalizations.of(context)!.login,
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
