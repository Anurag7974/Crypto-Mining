import 'package:btcmining/View/Wallet/userInfo.dart';
import 'package:btcmining/View/Wallet/view_more.dart';
import 'package:btcmining/View/Wallet/widget/income_expense_card.dart';
import 'package:btcmining/View/Wallet/widget/transaction_item_title.dart';
import 'package:btcmining/View/Widget/loading_manager.dart';
import 'package:btcmining/constants/colors.dart';
import 'package:btcmining/constants/sizes.dart';
import 'package:btcmining/provider/history_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../Login_Pages/auth/firebase_consts.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../Model/historyModel.dart';
import '../Model/orders_model.dart';
import 'history_Widget.dart';

class WalletScreen extends StatefulWidget {
  static const routeName = "/WalletScreen";
  const WalletScreen({Key? key}) : super(key: key);

  @override
  State<WalletScreen> createState() => _WalletScreenState();
}

class _WalletScreenState extends State<WalletScreen> {
  String? _income;
  String? _withdrawal;
  String? _name;
  String? _totBal;
  bool _isLoading = false;
  final User? user = authInstance.currentUser;
  @override
  void initState(){
    getUserData();
    super.initState();
  }

  Future<void> getUserData() async {
    setState(() {
      _isLoading = true;
    });
    if(user == null) {
      setState(() {
        _isLoading = false;
      });
      return;
    }
    try {
      String _uid = user!.uid;
      final DocumentSnapshot userDoc = await FirebaseFirestore.instance.collection('users').doc(_uid).get();
      if(userDoc == null) {
        return;
      } else {
        _name = userDoc.get('name');
        _totBal = userDoc.get('totBal');
        _income = userDoc.get('income');
        _withdrawal = userDoc.get('withdrawal');

      }
    } catch (error) {
      setState(() {
        _isLoading = false;
      });
      GlobalMethods.errorDialog(subtitle: '$error', context: context);
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    final historyProvider = Provider.of<HistoryProvider>(context);
    final historyList = historyProvider.getHistory;
    return RefreshIndicator(
      onRefresh: (){
        setState(() {});
        return Future.delayed(const Duration(seconds: 3));
      },
      child: LoadingManager(
        isLoading:_isLoading,
        child: SingleChildScrollView(
          child: Padding(
            padding:  const EdgeInsets.all(defaultSpacing),
            child: Column(
             crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: defaultSpacing,),
                ListTile(
                  title: Text("Hey! ${ _name == null ? 'name' : _name!}",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: fontSizeHeading, fontWeight: FontWeight.w600),),
                    // leading: ClipRRect(borderRadius: const BorderRadius.all(Radius.circular(defaultRadius)),
                    //     child: Image.asset("assets/image/profile.png")),
                  trailing: SizedBox(
                    height: 40,
                      width: 40,
                      child: Image.asset("assets/icons/bell.png")),
                ),
                const SizedBox(height: defaultSpacing,),
                Center(
                  child: Column(
                    children: [
                      Text("₹ ${ _totBal == null ? 'name' : _totBal!}",style: Theme.of(context).textTheme.titleLarge?.copyWith(fontSize: fontSizeHeading, fontWeight: FontWeight.w800),),
                      const SizedBox(height: defaultSpacing / 2,),
                      Text("Total balance",style: Theme.of(context).textTheme.bodyText1?.copyWith(color: fontSubHeading),),

                    ],
                  ),),
                const SizedBox(height: defaultSpacing * 2,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                   Expanded(child:IncomeExpenseCard(expenseData: ExpenseData("Income", "₹${_income == null ? 'name' : _income!}", Icons.arrow_upward_rounded))),
                    const SizedBox(width: defaultSpacing,),
                    Expanded(child:IncomeExpenseCard(expenseData: ExpenseData("Withdrawal", "- ${_withdrawal == null ? 'name' : _withdrawal!}", Icons.arrow_downward_rounded))),
                  ],
                ),
                const SizedBox(height: defaultSpacing * 2,),
                Text("History", style: Theme.of(context).textTheme.headline6?.copyWith(fontWeight: FontWeight.w700),),
                const SizedBox(height: 5 ,),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: SingleChildScrollView(
                    child: Container(
                      width: 400,
                      height: 350,
                      color: background,
                      child: FutureBuilder(
                        future: historyProvider.fetchHistory(),
                        builder: (context, snapshot) {
                         return historyList.isEmpty ?
                         const Center(
                             child: Text("You didn't place any withdrawal yet !", style: TextStyle(fontSize: 25),)) : ListView.separated(
                              itemBuilder: (ctx, index) {
                                return Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 2, vertical: 6),
                                    child: ChangeNotifierProvider.value(
                                      value: historyList[index],
                                      child: const HistoryWidget(),
                                    )
                                );
                              },
                              separatorBuilder: (BuildContext context, int index) {
                                return Divider(
                                  color: color,
                                  thickness: 1,
                                );
                              },
                              itemCount: historyList.length);
                        }),
                    ),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    TextButton(onPressed: (){
                      Navigator.of(context).push(MaterialPageRoute(builder: (context) =>  const ViewMore()));
                    },
                        child: const Text("View More", style: TextStyle(color: Colors.red, fontSize: 15, ),)),
                  ],
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
