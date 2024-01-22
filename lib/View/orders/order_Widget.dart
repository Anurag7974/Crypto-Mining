import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../provider/orders_provider.dart';
import '../../provider/products_provider.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../signupLogin/screen/inner_screen/product_details.dart';
import '../../signupLogin/screen/inner_screen/product_item_screen.dart';
import '../Components/text_widget.dart';
import '../Model/orders_model.dart';

class OrderWidget extends StatefulWidget {
  const OrderWidget({Key? key,}) : super(key: key);

  @override
  State<OrderWidget> createState() => _OrderWidgetState();
}

class _OrderWidgetState extends State<OrderWidget> {
  late String orderDateToShow;

  @override
  void didChangeDependencies() {
    final ordersModel = Provider.of<OrderModel>(context);
    var orderDate = ordersModel.orderDate.toDate();
    orderDateToShow = '${orderDate.day}/${orderDate.month}/${orderDate.year}';
    super.didChangeDependencies();
  }
  @override
  Widget build(BuildContext context) {
    final ordersModel = Provider.of<OrderModel>(context);
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProvider = Provider.of<ProductsProvider>(context);
    final getCurrProduct = productProvider.findProdById(ordersModel.productId);
    return ListTile(
      subtitle:  Text('Paid: \₹${double.parse(ordersModel.totalPrice).toStringAsFixed(2)}'),
      onTap: (){
        // GlobalMethods.navigateTo(ctx: context, routeName: ProductItemScreen.routeName);
      },
      leading:  FancyShimmerImage(
        width: size.width * 0.2,
        imageUrl: getCurrProduct.imageUrl,
        boxFit: BoxFit.fill,
      ),
      title: TextWidget(text: '${getCurrProduct.title} x${ordersModel.quantity}', color: color, textSize: 18,),
      trailing: TextWidget(text: '$orderDateToShow \n${ordersModel.complete}', color: Colors.red, textSize: 18,),
    );
  }
}