import 'package:btcmining/View/Widget/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/history_provider.dart';
import '../../services/utils.dart';
import '../backWidget.dart';
import '../orders/empty_screen.dart';
import 'history_Widget.dart';

class ViewMore extends StatelessWidget {
  static const routeName = "/ViewMore";
  const ViewMore({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final historyProvider = Provider.of<HistoryProvider>(context);
    final historyList = historyProvider.getHistory;
    bool _isLoading = false;
    return FutureBuilder(
        future: historyProvider.fetchHistory(),
        builder: (context, snapshot){
          return historyList.isEmpty ? const EmptyScreen(
            title: "You didn't place any withdrawal yet",
            subtitle: 'Waiting :)',
            // buttonText: 'Investment now',
            imagePath: 'assets/images/cart1.png',
          ): Scaffold(
              appBar: AppBar(
                leading: const BackWidget(),
                elevation: 2,
                backgroundColor: const Color(0xFFFFE400),
                centerTitle: true,
                title: Text("Withdrawal History", style: Theme.of(context).textTheme.headline5,),
          ),
          body: LoadingManager(
            isLoading: _isLoading,
            child:  ListView.separated(
                itemBuilder: (ctx, index) {
                  return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 6),
                      child: ChangeNotifierProvider.value(
                        value: historyList[index],
                        child: const HistoryWidget(),
                      )
                  );
                },
                separatorBuilder: (BuildContext context, int index) {
                  return Divider(
                    color: color,
                    thickness: 1,
                  );
                },
                itemCount: historyList.length),
          ),
          );
        });

  }

}