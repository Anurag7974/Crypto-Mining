import 'package:flutter/material.dart';

class ExpandedWidget extends StatefulWidget {
  const ExpandedWidget({Key? key, required this.text}) : super(key: key);
  final String text;

  @override
  _ExpandedWidgetState createState() => _ExpandedWidgetState();


}

class _ExpandedWidgetState extends State<ExpandedWidget> {
  @override
  Widget build(BuildContext context) {
     return Container(
       child: Text(
         widget.text
       ),
     );
  }
}