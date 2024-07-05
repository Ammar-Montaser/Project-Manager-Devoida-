import 'package:project_manager/features/auth/data/models/userModel.dart';
import 'package:project_manager/features/project/data/models/projectModel.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:project_manager/features/project/data/models/taskModel.dart';

abstract interface class ProjectsRemoteDB {
  Future<dynamic> getProjects();
  Future<dynamic> getUsers();
  Future<dynamic> getUser(id);
  Future<dynamic> getTasks(id);

  Future<dynamic> updateTasks(List<TaskModel> tasks, id);
  Future<dynamic> updateTaskProgress(TaskModel task, id);
  Future<dynamic> createProject(ProjectModel project);
  Future<dynamic> updateProject(ProjectModel project, id);
  Future<dynamic> deleteProject(String id);
}

class ProjectsRemoteDBImpl implements ProjectsRemoteDB {
  FirebaseFirestore firestore = FirebaseFirestore.instance;

  @override
  Future<dynamic> createProject(ProjectModel project) async {
    print(project);
    CollectionReference ref =
        await FirebaseFirestore.instance.collection('projects');

    String docId = ref.doc().id;
    project.id = docId;
    return ref.doc(docId).set(project.toJson());
  }

  @override
  Future deleteProject(String id) {
    return firestore.collection('projects').doc(id).delete();
  }

  @override
  Future getProjects() {
    return firestore.collection('projects').get().then((value) {
      print(value.docs);
      List<ProjectModel> projects = [];
      for (var project in value.docs) {
        projects.add(ProjectModel.fromJson(project.data()));
      }
      return projects;
    });
  }

  @override
  Future getTasks(id) {
    return firestore.collection('tasks').doc(id).get().then((value) {
      List<TaskModel> tasks = [];
      print(value.data());
      //pass index to from json function
      if (value.data() == null) return tasks;
      for (int i = 0; i < value.data()!['tasks'].length; i++) {
        tasks.add(TaskModel.fromJson(value.data()!['tasks'][i], i));
      }
      return tasks;
    });
  }

  @override
  Future updateProject(ProjectModel project, id) {
    return firestore.collection('projects').doc(id).update(project.toJson());
  }

  @override
  Future<List<UserModel>> getUsers() async {
    try {
      final QuerySnapshot<Map<String, dynamic>> querySnapshot =
          await firestore.collection("users").get();
      return querySnapshot.docs.map((doc) {
        return UserModel.fromJson(doc.data());
      }).toList();
    } catch (e) {
      throw Exception("Error fetching users: $e");
    }
  }

  @override
  Future updateTasks(List<TaskModel> tasks, id) {
    if (tasks == null || id == null) {
      throw ArgumentError("tasks or id cannot be null");
    }
    print(firestore
        .collection("tasks")
        .doc(id)
        .set({"tasks": tasks.map((task) => task.toJson()).toList()}));
    return firestore
        .collection("tasks")
        .doc(id)
        .set({"tasks": tasks.map((task) => task.toJson()).toList()}).catchError(
            (error) {
      throw Exception("Error updating tasks: $error");
    });
  }

  @override
  Future getUser(id) {
    return firestore.collection('users').doc(id).get().then((value) {
      return UserModel.fromJson(value.data()!);
    });
  }

  @override
  Future updateTaskProgress(TaskModel task, id) async {
    // get the current list of tasks
    DocumentSnapshot<Map<String, dynamic>> doc =
        await firestore.collection("tasks").doc(id).get();
    List<dynamic> tasks = doc.data()!['tasks'];

    // find the task to update, if it exists
    int index = tasks.indexWhere((t) => t['id'] == task.id);
    if (index != -1) {
      // update the task and maintain the order
      tasks[index] = task.toJson();
    } else {
      // add the new task to the end of the list
      tasks.add(task.toJson());
    }

    // update the tasks list
    return firestore
        .collection("tasks")
        .doc(id)
        .update({"tasks": tasks}).catchError((error) {
      throw Exception("Error updating tasks: $error");
    });
  }
}
