import 'package:flutter/material.dart';

class TasksModel with ChangeNotifier {
  final String heading, subHeading, deadLine;

  TasksModel({
    required this.heading,
    required this.subHeading,
    required this.deadLine,
  });
}