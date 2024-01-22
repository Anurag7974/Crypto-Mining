import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HistoryModel with ChangeNotifier {
  final String heading, subheading, amount;
  final Timestamp historyDate;

  HistoryModel({
    required this.heading,
    required this.subheading,
    required this.amount,
    required this.historyDate
  });
}