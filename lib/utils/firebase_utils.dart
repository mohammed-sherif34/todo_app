import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/authentication/auth_page.dart';
import 'package:todo_app/home_page/home_page.dart';
import 'package:todo_app/models/task.dart';
import 'package:todo_app/models/user.dart';
import 'package:todo_app/providers/config_provider.dart';
import 'package:todo_app/utils/snackbar_utils.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FireBaseUtils {
  //firebase fireStore methods..for tasks
  static CollectionReference<Task> tasksCollectionRef(String uid) {
    return FirebaseFirestore.instance
        .collection(MyUser.collection)
        .doc(uid)
        .collection(Task.collection)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static CollectionReference<MyUser> usersCollectionRef() {
    return FirebaseFirestore.instance
        .collection(MyUser.collection)
        .withConverter<MyUser>(
          fromFirestore: (snapshot, _) {
            // Use the converter to convert the snapshot to MyUser
            return MyUser.fromJson(snapshot.data()!);
          },
          toFirestore: (myUser, _) => myUser.toJson(),
        );
  }

  static Future<void> addUserToFireStore(MyUser? user) {
    return usersCollectionRef().doc(user?.id).set(user!);
  }

  static Future<void> addTask(Task task) {
    var taskDocRef = tasksCollectionRef(ConfigProvider.user.id).doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static void deleteTask(Task task, context) {
    tasksCollectionRef(ConfigProvider.user.id).doc(task.id).delete();
    SnackBarUtils.showSnackBar(
        context: context,
        text: AppLocalizations.of(context)!.taskDeletedSuccesfuly,
        configProvider: ConfigProvider());
  }

  static Future<String> updateTask({
    required Task task,
    required context,
    required ConfigProvider configProvider,
  }) {
    CollectionReference tasks = tasksCollectionRef(ConfigProvider.user!.id);
    return tasks.doc(task.id).update(task.toJson()).then((value) {
      configProvider.gettasksList();
      return AppLocalizations.of(context)!.taskUpdated;
    }).catchError((error) => 'Failed to update task: $error');
  }

// firebase auth methods login and register

  static void login({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController passwordController,
    required BuildContext context,
    required ConfigProvider configProvider,
  }) async {
    if (formKey.currentState!.validate()) {
      configProvider.setLoading(true);

      try {
        final credential =
            await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        var querySnapShot =
            await usersCollectionRef().doc(credential.user!.uid).get();
        ConfigProvider.user = querySnapShot.data() as MyUser;
        configProvider.gettasksList;
        SnackBarUtils.showSnackBar(
            configProvider: configProvider,
            // ignore: use_build_context_synchronously
            context: context,
            // ignore: use_build_context_synchronously
            text: AppLocalizations.of(context)!.loginSuccessfuly);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, HomePage.name);
        configProvider.setLoading(false);
      } on FirebaseAuthException catch (e) {
        SnackBarUtils.showSnackBar(
            seconds: 4,
            configProvider: configProvider,
            // ignore: use_build_context_synchronously
            context: context,
            text: 'Login Failed : ${e.message}');

        configProvider.setLoading(false);
      } catch (e) {
        configProvider.loading = true;
        SnackBarUtils.showSnackBar(
          seconds: 4,
          configProvider: configProvider,
          // ignore: use_build_context_synchronously
          context: context,
          text: e.toString(),
        );
        configProvider.setLoading(false);
      }
    }
  }

  static void register({
    required GlobalKey<FormState> formKey,
    required TextEditingController emailController,
    required TextEditingController userNameController,
    required TextEditingController passwordController,
    required BuildContext context,
    required ConfigProvider configProvider,
  }) async {
    if (formKey.currentState!.validate()) {
      configProvider.setLoading(true);

      try {
        final credential =
            await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailController.text,
          password: passwordController.text,
        );
        // addUserToFireStore(credential.us );
        ConfigProvider.user = MyUser(
            email: emailController.text,
            name: userNameController.text,
            id: credential.user!.uid);
        configProvider.gettasksList;
        addUserToFireStore(ConfigProvider.user);
        SnackBarUtils.showSnackBar(
            configProvider: configProvider,
            // ignore: use_build_context_synchronously
            context: context,
            // ignore: use_build_context_synchronously
            text: AppLocalizations.of(context)!.useraAddedSuccessfuly);
        // ignore: use_build_context_synchronously
        Navigator.pushReplacementNamed(context, HomePage.name);
        configProvider.setLoading(false);
      } on FirebaseAuthException catch (e) {
        //configProvider.loading = true;
        SnackBarUtils.showSnackBar(
            seconds: 4,
            configProvider: configProvider,
            // ignore: use_build_context_synchronously
            context: context,
            text: 'register Failed : ${e.message}');
        configProvider.setLoading(false);
      } catch (e) {
        configProvider.loading = true;
        SnackBarUtils.showSnackBar(
          seconds: 4,
          configProvider: configProvider,
          // ignore: use_build_context_synchronously
          context: context,
          text: e.toString(),
        );
        configProvider.setLoading(false);
      }
    }
  }

  static void signOut(context, configProvider) async {
    await FirebaseAuth.instance.signOut();
    configProvider.tasksList = <Task>[];
    //ConfigProvider.user = null;
    Navigator.pushReplacementNamed(context, AuthPage.name);
    SnackBarUtils.showSnackBar(
      context: context,
      text: AppLocalizations.of(context)!.logoutSuccessfuly,
      configProvider: ConfigProvider(),
    );
  }
}
