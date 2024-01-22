import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../View/Model/tasksModel.dart';

class TasksProvider with ChangeNotifier {
  static List<TasksModel> _TasksList = [];

  List<TasksModel> get getTasks {
    return _TasksList;
  }

  Future<void> fetchTask() async {
    await FirebaseFirestore.instance.collection('tasks').orderBy('deadLine',descending: true).get().then((
        QuerySnapshot productSnapshot) {
      _TasksList = [];
      productSnapshot.docs.forEach((element) {
        _TasksList.insert(0, TasksModel(
          heading: element.get('heading'),
          subHeading: element.get('subHeading'),
          deadLine: element.get('deadLine'),
        ));
      });
    });
    notifyListeners();
  }
}