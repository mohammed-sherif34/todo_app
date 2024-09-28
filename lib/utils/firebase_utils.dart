import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:todo_app/models/task.dart';

class FireBaseUtils {
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
}
