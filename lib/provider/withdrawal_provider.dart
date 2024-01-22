import 'package:flutter/cupertino.dart';
import '../View/Model/withdrawal_model.dart';

class WithdrawalProvider with ChangeNotifier {
  static List<WithdrawalModel> _withdrawal = [];
  List<WithdrawalModel> get getWithdrawals {
    return _withdrawal;
  }
}