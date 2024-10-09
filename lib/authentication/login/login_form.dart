import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/authentication/widgets/custom_auth_text_filed.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/app_colors.dart';
import 'package:todo_app/utils/firebase_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
    
  );

  TextEditingController passwordController = TextEditingController(
    
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
                    AppLocalizations.of(context)!.welcomeBack,
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
                    AppLocalizations.of(context)!.login,
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

                  //Spacer(),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: AppColors.blue),
                    onPressed: () {
                      FireBaseUtils.login(
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
                                  AppLocalizations.of(context)!.login,
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
                       Text(AppLocalizations.of(context)!.dontHaveAnAccount),
                      TextButton(
                        onPressed: widget.onPressed,
                        child: Text(
                          AppLocalizations.of(context)!.register,
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
