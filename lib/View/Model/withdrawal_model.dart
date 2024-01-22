import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';

class WithdrawalModel extends ChangeNotifier {
  final String withdrawalId, userId, userName, accountName, bank, account, city, branch, ifsc, amount;
  final Timestamp withdrawalDate;

  WithdrawalModel({
    required this.withdrawalDate,
    required this.userId,
    required this.userName,
    required this.accountName,
    required this.bank,
    required this.amount,
    required this.account,
    required this.branch,
    required this.city,
    required this.ifsc,
    required this.withdrawalId,
  });
}