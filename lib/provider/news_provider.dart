import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import '../View/Model/NewsModel.dart';

class NewsProvider with ChangeNotifier {
  static List<NewsModel> _NewsList = [];

  List<NewsModel> get getNews {
    return _NewsList;
  }

  Future<void> fetchNews() async {
    await FirebaseFirestore.instance.collection('news').orderBy('dateTime',descending: true).get().then((
        QuerySnapshot productSnapshot) {
      _NewsList = [];
      productSnapshot.docs.forEach((element) {
        _NewsList.insert(0, NewsModel(
          heading: element.get('heading'),
          newsImages: element.get('newsImages'),
          subHeading: element.get('subHeading'),
          dateTime: element.get('dateTime'),
        ));
      });
    });
    notifyListeners();
  }
}