import 'package:btcmining/View/Widget/price_widget.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../Model/products_model.dart';
import '../../provider/products_provider.dart';
import '../../services/global_method.dart';
import '../../services/utils.dart';
import '../../signupLogin/screen/inner_screen/product_details.dart';
import '../../signupLogin/screen/inner_screen/product_item_screen.dart';
import '../Components/text_widget.dart';
import 'buy_cart.dart';

class OnSaleWidget extends StatefulWidget {
  const OnSaleWidget({Key? key}) : super(key: key);

  @override
  State<OnSaleWidget> createState() => _OnSaleWidgetState();
}
class _OnSaleWidgetState extends State<OnSaleWidget> {
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        color: Theme.of(context).cardColor.withOpacity(0.9),
        borderRadius: BorderRadius.circular(12),
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            Navigator.pushNamed(context, ProductItemScreen.routeName, arguments: productModel.id);
          },
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      FancyShimmerImage(
                        imageUrl: productModel.imageUrl,
                        height: size.width * 0.22,
                        width: size.width * 0.22,
                        boxFit: BoxFit.fill,
                      ),
                      const SizedBox(width: 15),
                      Column(
                        children: [
                          TextWidget(
                            text: productModel.isDouble ? 'Single' : 'Double', color: color, textSize: 18, isTitle: true,),
                          const SizedBox(height: 6,),
                              const BuyCart(),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(height: 5),
                  PriceWidget(
                    salePrice: productModel.salePrice,
                    price: productModel.price,
                    isOnSale: true,
                  ),
                  const SizedBox(height: 5),
                  TextWidget(text: productModel.title, color: color, textSize: 20, isTitle: true,),
                  const SizedBox(height: 5),
                ]),
          ),
        ),
      ),
    );
  }

}