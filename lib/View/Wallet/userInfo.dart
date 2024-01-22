import 'package:firebase_auth/firebase_auth.dart';

import '../../Login_Pages/auth/firebase_consts.dart';

enum TransactionType {
  outflow,
  inflow
}
 enum ItemCategoryType {
  fashion, grocery, payments
 }


 class UserInfo {
  final String name;
  final String totalBalance;
  final String inflow;
  final String outflow;
  final List<Transaction> transactions;

  const UserInfo({
    required this.name,
    required this.totalBalance,
    required this.inflow,
    required this.outflow,
    required this.transactions,
  });

 }

 class Transaction {
  final ItemCategoryType categoryType;
  final TransactionType transactionType;
  final String itemCategoryName;
  final String itemName;
  final String amount;
  final String date;

  const Transaction(
      this.categoryType,
      this.transactionType,
      this.itemCategoryName,
      this.itemName,
      this.amount,
      this.date,
  );
 }

 const List<Transaction>transactions1 = [
   Transaction(ItemCategoryType.fashion, TransactionType.outflow, "Shoes", "Pune Sneaker", "₹3,500.08", "Oct, 23"),
   Transaction(ItemCategoryType.fashion, TransactionType.outflow, "Shoes", "Pune Sneaker", "₹3,500.08", "Oct, 23"),
 ];

 const List<Transaction>transactions2 = [
  Transaction(ItemCategoryType.payments, TransactionType.inflow, "Payment", "Transfer from Eden", "₹23,500.08", "Oct, 23"),
  Transaction(ItemCategoryType.grocery, TransactionType.outflow, "Chicken", "Chicken Wing", "₹32,500.08", "Oct, 23"),
   Transaction(ItemCategoryType.payments, TransactionType.outflow, "Payment", "Transfer from Eden", "₹23,500.08", "Oct, 23"),
   Transaction(ItemCategoryType.grocery, TransactionType.outflow, "Chicken", "Chicken Wing", "₹32,500.08", "Oct, 23"),

];

 const userdata = UserInfo(
     name: "Anurag",
     totalBalance: "4,568.03",
     inflow: "4,88.88",
     outflow: "₹2000.00",
     transactions: transactions1);
