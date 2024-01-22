import 'package:btcmining/View/Model/historyModel.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/history_provider.dart';
import '../../services/utils.dart';
import '../Components/text_widget.dart';

class HistoryWidget extends StatefulWidget {
  const HistoryWidget({Key? key,}) : super(key: key);

  @override
  State<HistoryWidget> createState() => _HistoryWidgetState();
}

class _HistoryWidgetState extends State<HistoryWidget> {
  late String historyDateToShow;

  @override
  void didChangeDependencies() {
    final historyModel = Provider.of<HistoryModel>(context);
    var historyDate = historyModel.historyDate.toDate();
    historyDateToShow = '${historyDate.day}/${historyDate.month}/${historyDate.year}';
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final historyModel = Provider.of<HistoryModel>(context);
    final Color color = Utils(context).color;
    return SingleChildScrollView(
      child: ListTile(
        subtitle:  Text(historyModel.subheading),
        title: TextWidget(text: historyModel.heading, color: color, textSize: 18, isTitle: false,),
        trailing: TextWidget(text: '${historyModel.amount} \n${historyDateToShow}', color: Colors.red, textSize: 12, isTitle: true,),
      ),
    );
  }
}