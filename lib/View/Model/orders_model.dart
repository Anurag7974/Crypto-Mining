import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class OrderModel with ChangeNotifier {
  final String orderId, userId, productId, userName, price, imageUrl, quantity, totalPrice, complete;
  final Timestamp orderDate;

  OrderModel({
    required this.quantity,
    required this.orderId,
    required this.userId,
    required this.productId,
    required this.userName,
    required this.price,
    required this.complete,
    required this.totalPrice,
    required this.imageUrl,
    required this.orderDate,
  });
}