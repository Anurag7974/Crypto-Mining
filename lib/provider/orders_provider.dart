import 'package:btcmining/Login_Pages/auth/firebase_consts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../View/Model/orders_model.dart';

class OrdersProvider with ChangeNotifier {
  static List<OrderModel> _orders = [];

  List<OrderModel> get getOrders {
    return _orders;
  }

  Future<void> fetchOrders() async {
    User? user = authInstance.currentUser;
    final _uid = user!.uid;
    await FirebaseFirestore.instance.collection('users').doc(_uid).collection('userOrder').orderBy('orderDate',descending: true).get().then((
        QuerySnapshot ordersSnapshot){
      _orders = [];
      ordersSnapshot.docs.forEach((element) {
        _orders.insert(0,
           OrderModel(
               quantity: element.get('quantity').toString(),
               orderId: element.get('orderId'),
               userId: element.get('userId'),
               productId: element.get('productId'),
               userName: element.get('userName'),
               price: element.get('price').toString(),
               totalPrice: element.get('totalPrice').toString(),
               imageUrl: element.get('imageUrl'),
               complete : element.get('complete'),
               orderDate: element.get('orderDate'),
           ));
      });
    });
    notifyListeners();
  }

}