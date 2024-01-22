import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/orders_provider.dart';
import '../../services/utils.dart';
import '../Components/text_widget.dart';
import '../backWidget.dart';
import 'empty_screen.dart';
import 'order_Widget.dart';

class OrdersScreen extends StatelessWidget {
  static const routeName = "/OrdersScreen";
  const OrdersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final ordersProvider = Provider.of<OrdersProvider>(context);
    final ordersList = ordersProvider.getOrders;
    // bool _isEmpty = false;
   return FutureBuilder(
     future: ordersProvider.fetchOrders(),
     builder: (context, snapshot) {
       return ordersList.isEmpty ? const EmptyScreen(
         title: 'You didnt place any investment yet',
         subtitle: 'Add something and make me happy :)',
         // buttonText: 'Investment now',
         imagePath: 'assets/images/cart1.png',
       ) : Scaffold(
         appBar: AppBar(
           leading: const BackWidget(),
           elevation: 2,
           centerTitle: true,
           backgroundColor: const Color(0xFFFFE400),
           title: Text("Your Investment (${ordersList.length})", style: Theme.of(context).textTheme.headline5,),
           // TextWidget(text: 'Your Investment (${ordersList.length})',
           //   color: const Color(0xFFFFE400),
           //   isTitle: true,
           //   textSize: 22.0,),
         ),
         body: ListView.separated(
             itemCount: ordersList.length,
             itemBuilder: (ctx, index) {
               return Padding(
                 padding: const EdgeInsets.symmetric(
                     horizontal: 2, vertical: 6),
                 child: ChangeNotifierProvider.value(
                     value: ordersList[index],
                     child: const OrderWidget()),
               );
             },
             separatorBuilder: (BuildContext context, int index) {
               return Divider(
                 color: color,
                 thickness: 1,
               );
             }
         ),
       );
     }
     );
  }
}