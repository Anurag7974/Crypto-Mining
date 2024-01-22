import 'package:flutter/material.dart';
import '../../services/utils.dart';
import '../Components/text_widget.dart';

class PriceWidget extends StatelessWidget {
  const PriceWidget({
    Key? key, required this.salePrice, required this.price, required this.isOnSale
  }) : super(key: key);
  final double salePrice, price;
  final bool isOnSale;


  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    double userPrice = isOnSale? salePrice : price;
    return FittedBox(
        child: Row(
          children: [
            TextWidget(text: '₹ ${userPrice.toStringAsFixed(2)}', color: Colors.green, textSize: 18,),
            const SizedBox(width: 5,),
            Visibility(
              visible: isOnSale? true : false,
              child: Text('₹ ${price.toStringAsFixed(2)}',
                style: TextStyle(fontSize: 15, color: color, decoration: TextDecoration.lineThrough,),),
            )
          ],
        ));
  }
}
