import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:uuid/uuid.dart';

import '../Login_Pages/auth/firebase_consts.dart';
import '../View/Components/text_widget.dart';

class GlobalMethods {
  static navigateTo({required BuildContext ctx, required String routeName}) {
    Navigator.pushNamed(ctx, routeName);
  }
  /// ************************* How to show Dialog button ***************************************************
  static Future<void> warningDialog({
    required String title,
    required String subtitle,
    required Function fct,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset('assets/image/warning-sign.png', height: 20, width: 20, fit: BoxFit.fill,),
              const SizedBox(width: 8,),
              Text(title),
            ],),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'Cancel',
                  textSize: 18,
                ),
              ),
              TextButton(onPressed: () {
                fct();
                if (Navigator.canPop(context)) {
                  Navigator.pop(context);
                }
              },
                child: TextWidget(
                  color: Colors.red,
                  text: 'oK',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }
  /// ************************* End! ***************************************************
  static Future<void> errorDialog({
    required String subtitle,
    required BuildContext context,
  }) async {
    await showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            title: Row(children: [
              Image.asset('assets/image/warning-sign.png', height: 20, width: 20, fit: BoxFit.fill,),
              const SizedBox(width: 8,),
              const Text('An Error occurred'),
            ],),
            content: Text(subtitle),
            actions: [
              TextButton(
                onPressed: () {
                  if (Navigator.canPop(context)) {
                    Navigator.pop(context);
                  }
                },
                child: TextWidget(
                  color: Colors.cyan,
                  text: 'ok',
                  textSize: 18,
                ),
              ),
            ],
          );
        });
  }
  static Future<void> orderProducts(
      {required String productId,
        required double price,
        required double totalPrice,
        required int quantity,
        required String imageUrl,
        required BuildContext context}) async {
    final User? user = authInstance.currentUser;
    final _uid = user!.uid;
    final orderId = const Uuid().v4();
    try {
      FirebaseFirestore.instance.collection('users').doc(_uid).update({
        'userOrder': FieldValue.arrayUnion([
          {
            'orderId': orderId,
            'userId': user.uid,
            'productId': productId,
            'price':     price, // (getCurrProduct.isOnSale ? getCurrProduct.salePrice : getCurrProduct.price) *  int.parse(_quantityTextController.text),
            'totalPrice' : totalPrice, // totalPrice,
            'quantity' : quantity,
            'imageUrl' :imageUrl,
            'userName' : user.displayName,
            'complete' : "",
            'orderDate' : Timestamp.now(),
          }
        ])
      });
      await Fluttertoast.showToast(
        msg: "Thank you for your investment.",
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
      );
    } catch (error) {
      errorDialog(subtitle: error.toString(), context: context);
    }
  }
}