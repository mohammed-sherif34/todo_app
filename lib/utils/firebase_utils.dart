import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:todo_app/models/task.dart';

class FireBaseUtils {
  //firebase fireStore methods
  static CollectionReference<Task> collectionRef() {
    return FirebaseFirestore.instance
        .collection(Task.collection)
        .withConverter<Task>(
          fromFirestore: (snapshot, _) => Task.fromJson(snapshot.data()!),
          toFirestore: (task, _) => task.toJson(),
        );
  }

  static Future<void> addTask(Task task) {
    var taskDocRef = collectionRef().doc();
    task.id = taskDocRef.id;
    return taskDocRef.set(task);
  }

  static void deleteTask(Task task) {
    collectionRef().doc(task.id).delete();
  }

  static Future<void> updateTask(
      {required Task task,
      required Map<String, dynamic> updatedData}) {
    CollectionReference tasks = collectionRef();
    return tasks
        .doc(task.id)
        .update(updatedData)
        .then((value) => print("task Updated"))
        .catchError((error) => print("Failed to update task: $error"));
  }
  static void login({required GlobalKey<FormState> formKey,
      required TextEditingController emailController,
      required TextEditingController passwordController} ) async {
    formKey.currentState!.validate();
    try {
      final credential = await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('login successfuly');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        print('No user found for that email.');
      } else if (e.code == 'wrong-password') {
        print('Wrong password provided for that user.');
      }
    }
  }
  // firebase auth methods
  static void register(
      {required GlobalKey<FormState> formKey,
      required TextEditingController emailController,
      required TextEditingController passwordController}) async {
    formKey.currentState!.validate();
    try {
      final credential =
          await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: emailController.text,
        password: passwordController.text,
      );
      print('user added successfuly');
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    } catch (e) {
      print(e);
    }
  }
}
