import 'package:btcmining/View/Tasks/task_Widgets.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/tasks_provider.dart';
import '../../services/utils.dart';
import '../News/news_Widgets.dart';
import '../backWidget.dart';
import '../orders/empty_screen.dart';

class TasksScreen extends StatelessWidget {
  static const routeName = "/TasksScreen";
  const TasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final tasksProvider = Provider.of<TasksProvider>(context);
    final tasksList = tasksProvider.getTasks;
    return FutureBuilder(
        future: tasksProvider.fetchTask(),
        builder: (context, snapshot) {
          return tasksList.isEmpty ? const EmptyScreen(
            title: 'You didnt place any tasks yet',
            subtitle: 'Waiting :)',
            // buttonText: 'Investment now',
            imagePath: 'assets/images/cart1.png',
          ) : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 2,
              backgroundColor: const Color(0xFFFFE400),
              centerTitle: true,
              title: Text("My Tasks", style: Theme.of(context).textTheme.headline5,),
            ),
            body: Container(
              color: Colors.grey[200],
              // padding: EdgeInsets.all(10),
              child: ListView.separated(
                  itemCount: tasksList.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 0, vertical: 5),
                      child: ChangeNotifierProvider.value(
                          value: tasksList[index],
                          child: const TasksWidget()),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return const Divider(
                      color: Colors.grey,
                      thickness: 0,
                    );
                  }
              ),
            ),
          );
        }
    );
  }
}