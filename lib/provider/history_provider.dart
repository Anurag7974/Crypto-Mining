import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../Login_Pages/auth/firebase_consts.dart';
import '../View/Model/historyModel.dart';

class HistoryProvider with ChangeNotifier {
  static List<HistoryModel> _history = [];

  List<HistoryModel> get getHistory {
    return _history;
  }

  Future<void> fetchHistory() async {
    User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).collection('withdrawalHistory').orderBy('historyDate',descending: true).get().then((
        QuerySnapshot ordersSnapshot){
      _history = [];
      ordersSnapshot.docs.forEach((element) {
        _history.insert(0, HistoryModel(
              heading: element.get('heading'),
              subheading: element.get('subheading'),
              amount: element.get('amount'),
              historyDate: element.get('historyDate'),
            ));
      });
    });
    notifyListeners();
  }

}