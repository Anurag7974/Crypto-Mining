import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';
import '../Components/text_widget.dart';
import '../Model/tasksModel.dart';

class TasksWidget extends StatefulWidget {
  const TasksWidget({Key? key}) : super(key: key);

  @override
  _TasksWidgetState createState() => _TasksWidgetState();
}

class _TasksWidgetState extends State<TasksWidget> {
  late String newsDateToShow;

  @override
  Widget build(BuildContext context) {
    final tasksModel = Provider.of<TasksModel>(context);
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return Card(
      elevation: 1,
      child: ListTile(
        subtitle:  Text(tasksModel.subHeading, style: const TextStyle(fontSize: 15),),
        title: TextWidget(text: tasksModel.heading, color: color, textSize: 22, isTitle: true,),
        leading: TextWidget(text:'DeadLine :-\n${tasksModel.deadLine}', color: Colors.red, textSize: 12, isTitle: true,),
      ),
    );
  }
}