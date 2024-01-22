import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:share_plus/share_plus.dart';

import '../../utils/message.dart';
import '../backWidget.dart';

class ReferEarn extends StatefulWidget {
  const ReferEarn({super.key});

  @override
  State<ReferEarn> createState() => _ReferEarnState();
}

class _ReferEarnState extends State<ReferEarn> {
  CollectionReference profileRef = FirebaseFirestore.instance.collection("users");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 2,
        backgroundColor: const Color(0xFFFFE400),
        centerTitle: true,
        title: Text("Refer & Earn", style: Theme.of(context).textTheme.headline5,),
      ),
      body: FutureBuilder<QuerySnapshot>(
        future: profileRef.where("refCode", isEqualTo: FirebaseAuth.instance.currentUser!.uid).get(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          final data = snapshot.data!.docs[0];
          final earnings = data.get("refEarning");
          List referralsList = data.get('referrals');
          final refCode = data.get("refCode");
          return Container(
            padding: const EdgeInsets.all(10),
            child:  RefreshIndicator(
              onRefresh: (){
                setState(() {});
                return Future.delayed(const Duration(seconds: 3));
              },
              child: CustomScrollView(
                slivers: [
                  SliverToBoxAdapter(
                    child: Column(
                      children: [
                         Card(
                          child: ListTile(
                            title: const Text("Earnings"),
                            subtitle: Text("₹ $earnings"),
                          ),
                        ),
                        const Divider(thickness: 3,),
                        Card(
                          child: ListTile(
                            title: const Text("Referral Code"),
                            subtitle:  Text(refCode),
                            trailing: IconButton(onPressed: () {
                              ClipboardData data =
                              ClipboardData(text: refCode);

                              Clipboard.setData(data);

                              showMessage(context, "Referral code copied");
                            }, icon: const Icon(Icons.copy)),
                          ),
                        ),
                        const Divider(thickness: 3,),
                      Card(
                       child: Column(
                         children: [
                           const Padding(padding: EdgeInsets.all(20),
                           child: Text("Suggest your friends to invest in BTC Mining to enjoy all the benefits, once they invest in BTC Mining, When someone user your referral link and invest in any BTC Mining Coin.\n You will get Rs.100 & 8% Percent of his investment.",
                           textAlign: TextAlign.center,),
                           ),
                           Container(
                             child: TextButton(onPressed: (){
                               String shareLink = "Hey! use this app to do stuffs and earn NGN 500 after using my ref code ($refCode) ";
                               Share.share(shareLink);
                             }, child: const Text("Share Link")),
                           )
                         ],),
                        ),
                        const Divider(thickness: 3,),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text("Referrals"),
                              Text("${referralsList.length}"),
                            ],
                          ),
                        ),
                        if (referralsList.isEmpty) const Text("No Referrals"),
                        ...List.generate(referralsList.length, (index) {
                          final data = referralsList[index];
                          return Container(
                            height: 50,
                            margin: const EdgeInsets.only(bottom: 10),
                            child: ListTile(
                              leading: CircleAvatar(
                                child: Text("${index + 1}"),
                              ),
                              title: Text(data),
                            ),
                          );
                        })
                      ],
                    ),
                  )
                ],
              ),
            ),
          );
        }
      ),
    );
  }

}