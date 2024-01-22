import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

class NewsModel with ChangeNotifier {
  final String heading, newsImages, subHeading;
  final Timestamp dateTime;

  NewsModel({
    required this.heading,
    required this.newsImages,
    required this.subHeading,
    required this.dateTime,
  });
}