import 'package:btcmining/View/Widget/loading_manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/news_provider.dart';
import '../../services/utils.dart';
import '../backWidget.dart';
import '../orders/empty_screen.dart';
import 'news_Widgets.dart';

class NewsScreen extends StatelessWidget {
  static const routeName = "/NewsScreen";
  const NewsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final newsProvider = Provider.of<NewsProvider>(context);
    final newsList = newsProvider.getNews;
    bool _isLoading = false;
    return FutureBuilder(
        future: newsProvider.fetchNews(),
        builder: (context, snapshot) {
          return newsList.isEmpty ? const EmptyScreen(
            title: "You didn't place any news yet",
            subtitle: 'Waiting :)',
            // buttonText: 'Investment now',
            imagePath: 'assets/images/cart1.png',
          ) : Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 2,
              backgroundColor: const Color(0xFFFFE400),
              centerTitle: true,
              title: Text("News List", style: Theme.of(context).textTheme.headline5,),
            ),
            body: LoadingManager(
              isLoading: _isLoading,
              child: ListView.separated(
                  // scrollDirection: Axis.vertical,
                  // reverse: true,
                  itemCount: newsList.length,
                  itemBuilder: (ctx, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 2, vertical: 10),
                      child: ChangeNotifierProvider.value(
                          value: newsList[index],
                          child: const NewsWidget()),
                    );
                  },
                  separatorBuilder: (BuildContext context, int index) {
                    return Divider(
                      color: color,
                      thickness: 1,
                    );
                  }
              ),
            ),
          );
        }
    );
  }
}