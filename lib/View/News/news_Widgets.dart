import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../provider/news_provider.dart';
import '../Components/text_widget.dart';
import '../Model/NewsModel.dart';
import '../backWidget.dart';
import '../../services/utils.dart';

class NewsWidget extends StatefulWidget {
  const NewsWidget({Key? key}) : super(key: key);

  @override
  _NewsListScreenState createState() => _NewsListScreenState();
}

class _NewsListScreenState extends State<NewsWidget> {
  late String newsDateToShow;

  @override
  void didChangeDependencies() {
    final newsModel = Provider.of<NewsModel>(context);
    var newsDate = newsModel.dateTime.toDate();
    newsDateToShow = '${newsDate.day}/${newsDate.month}/${newsDate.year}';
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    final newsModel = Provider.of<NewsModel>(context);
    Size size = Utils(context).getScreenSize;
    final Color color = Utils(context).color;
    return ListTile(
      subtitle:  Text(newsModel.subHeading, style: TextStyle(),),
      leading:  FancyShimmerImage(
        width: size.width * 0.2,
        height: size.height * 0.10,
        imageUrl: newsModel.newsImages,
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(text: newsModel.heading, color: color, textSize: 22, isTitle: false,),
      trailing: TextWidget(text: newsDateToShow, color: Colors.red, textSize: 18, isTitle: true,),
    );
  }
}
