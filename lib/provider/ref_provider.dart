import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../enums/state.dart';

class RefProvider extends ChangeNotifier {
  ViewState state = ViewState.Idle;
  String message = "";
  CollectionReference profileRef = FirebaseFirestore.instance.collection("users");
  FirebaseAuth auth = FirebaseAuth.instance;

  setReferral(String refCode) async {
    state = ViewState.Busy;
    notifyListeners();

    try {
      final querySnapshot  = await profileRef.where("refCode", isEqualTo: refCode).get();

      if (querySnapshot .docs.isEmpty) {
        ///ref code is not available
        message = 'Refcode is not available';
        state = ViewState.Error;
        notifyListeners();
      } else {
        /// It exists
        final documentSnapshot  = querySnapshot .docs[0];
        final data  = documentSnapshot .data() as Map<String, dynamic>;
        ///Get referrals
        List<dynamic> referrals = List.from(data['referrals'] ?? []);

        referrals .add(auth.currentUser!.email);

        // Update the ref earning
        final newRefEarnings = (data['refEarnings'] ?? 0) + 500;

        ///Update the ref earning
        final updateData = {
          "referrals": referrals,
          "refEarning": newRefEarnings,
        };

        // Update the document
        await profileRef.doc(documentSnapshot.id).update(updateData);

        message = "Ref success";
        state = ViewState.Success;
        notifyListeners();
      }
    } on FirebaseException catch (e) {
      message = e.message.toString();
      state = ViewState.Error;
      notifyListeners();
    }
  }
}