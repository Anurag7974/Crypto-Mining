import 'package:btcmining/View/Widget/price_widget.dart';
import 'package:btcmining/services/global_method.dart';
import 'package:btcmining/signupLogin/screen/inner_screen/product_details.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import '../Model/products_model.dart';
import '../../services/utils.dart';
import '../../signupLogin/screen/inner_screen/product_item_screen.dart';
import '../Components/text_widget.dart';
import 'buy_cart.dart';

class FeedsWidget extends StatefulWidget {
  const FeedsWidget({Key? key}) : super(key: key);

  @override
  State<FeedsWidget> createState() => _FeedsWidgetState();
}

class _FeedsWidgetState extends State<FeedsWidget> {
  final _quantityTextController = TextEditingController();

  @override
  void initState() {
    _quantityTextController.text = '1';
    super.initState();
  }

  @override
  void dispose() {
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productModel = Provider.of<ProductModel>(context);
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Material(
        borderRadius: BorderRadius.circular(12),
        color: Theme.of(context).cardColor,
        child: InkWell(
          onTap: () {
            Navigator.pushNamed(context, ProductItemScreen.routeName, arguments: productModel.id);
            // GlobalMethods.navigateTo(ctx: context, routeName: ProductItemScreen.routeName);
          },
          borderRadius: BorderRadius.circular(12),
          child: Column(children: [
            FancyShimmerImage(
              imageUrl: productModel.imageUrl,
              height: size.width * 0.35,
              width: size.width * 0.40,
              boxFit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  TextWidget(text: productModel.title, color: color, textSize: 20, isTitle: true,),
                  const BuyCart(),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                   PriceWidget(
                     salePrice: productModel.salePrice,
                     price: productModel.price,
                       isOnSale: productModel.isOnSale,
                   ),
                  const SizedBox(
                    width: 8,
                  ),
                  const Flexible(
                    child: Row(
                      children: [
                        SizedBox(
                          width: 5,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            // const Spacer(),
            SizedBox(
              width: double.infinity,
              child: TextButton(
                onPressed: () {
                  Navigator.pushNamed(context, ProductItemScreen.routeName, arguments: productModel.id);
                },
                style: ButtonStyle(
                    // backgroundColor: MaterialStateProperty.all(Theme.of(context).cardColor) ,
                    backgroundColor:   MaterialStateProperty.resolveWith<Color>((states) {
                      return const Color(0xffFBC700); // Change to your normal color
                    }),
                    tapTargetSize: MaterialTapTargetSize.shrinkWrap,
                    shape: MaterialStateProperty.all<RoundedRectangleBorder>(
                      const RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          bottomLeft: Radius.circular(12.0),
                          bottomRight: Radius.circular(12.0),
                        ),
                      ),
                    )),
                child: TextWidget(
                  text: 'View',
                  maxLines: 1, color: color, textSize: 20,
                ),
              ),
            )
          ]),
        ),
      ),
    );
  }
}
