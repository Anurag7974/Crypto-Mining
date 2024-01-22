import 'dart:ui';

import 'package:btcmining/Login_Pages/auth/firebase_consts.dart';
import 'package:btcmining/View/Components/text_widget.dart';
import 'package:btcmining/View/Widget/price_widget.dart';
import 'package:btcmining/provider/orders_provider.dart';
import 'package:btcmining/services/global_method.dart';
import 'package:btcmining/signupLogin/screen/inner_screen/expanded_widget.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:readmore/readmore.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:uuid/uuid.dart';

import '../../../View/Model/products_model.dart';
import '../../../View/backWidget.dart';
import '../../../provider/products_provider.dart';
import '../../../services/utils.dart';

class ProductItemScreen extends StatefulWidget {
  static const routeName = '/ProductItemScreen';
  const ProductItemScreen({Key? key}) : super(key: key);

  @override
  State<ProductItemScreen> createState() => _ProductItemScreenState();
}

class _ProductItemScreenState extends State<ProductItemScreen> {
  final _quantityTextController = TextEditingController(text: '1');


  @override
  void dispose(){
    //  Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final productProvider = Provider.of<ProductsProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findProdById(productId);
    final Color color = Utils(context).color;
      return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              leading: const BackWidget(),
              elevation: 2,
              backgroundColor: const Color(0xFFFFE400),
              centerTitle: true,
              title: Text("Coins Details", style: Theme.of(context).textTheme.headline5,),
            ),
            body: Stack(
              children: [
                // **********************  App Bar Images ***********************************
                SizedBox(
                  width: double.infinity,
                  child: FancyShimmerImage(
                      imageUrl: getCurrProduct.imageUrl,
                      boxFit: BoxFit.scaleDown,
                    ),
                  ),
                //**********************  End!  ***********************************
                // buttonArrow(context),
                scroll(),
              ],
            ),
          )
      );
  }

  // buttonArrow(BuildContext context) {
  //   return Padding(
  //     padding: const EdgeInsets.all(20.0),
  //     child: InkWell(
  //       onTap: (){
  //         Navigator.pop(context);
  //       },
  //       child: Container(
  //         clipBehavior: Clip.hardEdge,
  //         height: 55,
  //         width: 55,
  //         decoration: BoxDecoration(
  //           borderRadius: BorderRadius.circular(25),
  //         ),
  //         child: BackdropFilter(
  //           filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
  //           child: Container(
  //             height: 55,
  //             width: 55,
  //             decoration: BoxDecoration(borderRadius: BorderRadius.circular(25)
  //             ),
  //             child: const Icon(Icons.arrow_back, size: 20, color: Colors.red,),
  //           ),
  //         ),
  //       ),
  //     ),
  //   );
  // }

  scroll() {
    final Color color = Utils(context).color;
    // double userPrice = isOnSale? salePrice : price;
    final productProvider = Provider.of<ProductsProvider>(context);
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final getCurrProduct = productProvider.findProdById(productId);
    double usedPrice = getCurrProduct.isOnSale ? getCurrProduct.salePrice : getCurrProduct.price;
    double totalPrice = usedPrice * int.parse(_quantityTextController.text);
    double quantity = usedPrice * int.parse(_quantityTextController.text);
    final ordersProvider = Provider.of<OrdersProvider>(context);
    double total = 0.0;
    double income = 0.0;
    total += (getCurrProduct.isOnSale
        ? getCurrProduct.salePrice
        : getCurrProduct.price) *
     int.parse(_quantityTextController.text);
    income += (int.parse(getCurrProduct.income)) *
        int.parse(_quantityTextController.text);
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    final Uri orderLink = Uri.parse('https://cosmofeed.com/vp/65184a562dab22001ecd064a');
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 1.0,
        minChildSize: 0.6,
        builder: (context, scrollController){
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          clipBehavior: Clip.hardEdge,
          decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(30), topRight: Radius.circular(30)
            )
          ),
          child: SingleChildScrollView(
            controller: scrollController,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(top: 10, bottom: 25),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        height: 5,
                        width: 35,
                        color: Colors.black12,
                      )
                    ],
                  ),
                ),
                //**********************  Title  ***********************************
                Text(getCurrProduct.title, style: Theme.of(context).textTheme.headline4!.copyWith(color: Colors.black),),
                // const SizedBox(height: 10,),
                Text("Investment", style: Theme.of(context).textTheme.bodyText2!.copyWith(color:Colors.grey),),
                const SizedBox(height: 10,),
                //**********************  End!  ***********************************

                //**********************  Price Details  ***********************************
                const Divider(height: 15,),
                 Column(
                   children: [
                     Padding(
                       padding: EdgeInsets.symmetric(
                           horizontal: myWidth * 0.04, vertical: myHeight * 0.02),
                       child: Row(
                           mainAxisAlignment: MainAxisAlignment.spaceBetween,
                         children: [
                           Column(
                             children: [
                               const Text('Buy',
                                 style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.normal,
                                     color: Colors.grey),
                               ),
                               SizedBox(
                                 height: myHeight * 0.01,
                               ),
                               Text(
                                 '₹ ${usedPrice.toStringAsFixed(2)}',
                                 style: const TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.normal,
                                     color: Colors.black),
                               ),
                               const SizedBox(width: 10,),
                                    Visibility(
                                       visible: getCurrProduct.isOnSale ? true : false,
                                       child:
                                       Text(
                                         getCurrProduct.price.toStringAsFixed(2),
                                         style: const TextStyle(fontSize: 15, color: Colors.grey, decoration: TextDecoration.lineThrough),)
                                   ),
                               Text("Investment", style: Theme.of(context).textTheme.bodyText2!.copyWith(color:Colors.grey),),
                             ],
                           ),
                           Column(
                             children: [
                               const Text('Daily',
                                 style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.normal,
                                     color: Colors.grey),
                               ),
                               SizedBox(
                                 height: myHeight * 0.01,
                               ),
                               Text(
                                 '₹ ${getCurrProduct.income}',
                                 style: const TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.normal,
                                     color: Colors.black),
                               ),
                               Text("Income", style: Theme.of(context).textTheme.bodyText2!.copyWith(color:Colors.grey),),
                             ],
                           ),
                           Column(
                             children: [
                               const Text('Cycle',
                                 style: TextStyle(
                                     fontSize: 20,
                                     fontWeight: FontWeight.normal,
                                     color: Colors.grey),
                               ),
                               SizedBox(
                                 height: myHeight * 0.01,
                               ),
                               Text(
                                 '₹ ${getCurrProduct.cycleDays}',
                                 style: const TextStyle(
                                     fontSize: 18,
                                     fontWeight: FontWeight.normal,
                                     color: Colors.black),
                               ),
                               Text("Income", style: Theme.of(context).textTheme.bodyText2!.copyWith(color:Colors.grey),),
                             ],
                           )
                         ],
                       ),
                     )
                   ],
                 ),
                // Row(
                //   children: [
                //     const CircleAvatar(
                //       radius: 20,
                //       backgroundColor: Colors.white,
                //       backgroundImage: AssetImage("assets/splash/buy.png")
                //     ),
                //     const SizedBox(width: 5,),
                //     // PriceWidget(
                //     //   salePrice: productModel.salePrice,
                //     //   price: productModel.price,
                //     //   isOnSale: productModel.isOnSale,
                //     // )
                //     Text("₹", style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.green),),
                //     const SizedBox(width: 2,),
                //     Text(getCurrProduct.price.toStringAsFixed(2), style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.green),),
                //     Text("/-", style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.
                //     green),),
                //     const SizedBox(width: 10,),
                //      Visibility(
                //         visible: getCurrProduct.isOnSale ? true : false,
                //         child:
                //         Text(
                //           getCurrProduct.salePrice.toStringAsFixed(2),
                //           style: const TextStyle(fontSize: 15, color: Colors.grey, decoration: TextDecoration.lineThrough),)
                //     ),
                //   ],
                // ),
                // const SizedBox(height: 15, ),
                // Row(
                //   children: [
                //     const SizedBox(width: 5,),
                //     const CircleAvatar(
                //         radius:15,
                //         backgroundColor: Colors.white,
                //         backgroundImage: AssetImage("assets/splash/dezeen_daily-removebg-preview.png")
                //     ),
                //     const SizedBox(width: 8,),
                //     Text("₹", style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red),),
                //     const SizedBox(width: 2,),
                //     Text(getCurrProduct.income, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.red),),
                //     Text("/-", style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.red),),
                //     const SizedBox(width: 10,),
                //   ],
                // ),
                // const SizedBox(height: 15, ),
                // Row(
                //   children: [
                //     const SizedBox(width: 5,),
                //     const CircleAvatar(
                //         radius:15,
                //         backgroundColor: Colors.white,
                //         backgroundImage: AssetImage("assets/splash/cycle-removebg-preview.png")
                //     ),
                //     const SizedBox(width: 8,),
                //     Text(getCurrProduct.cycleDays, style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.blue),),
                //     const SizedBox(width: 5,),
                //     Text("Days", style: Theme.of(context).textTheme.bodyText2!.copyWith(color: Colors.blue),),
                //     const SizedBox(width: 10,),
                //   ],
                // ),
                //**********************  End!  ***********************************
                const SizedBox(height: 15, ),
                //**********************  Quantity Controller ***********************************
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    quantityController(fct: () {
                      if(_quantityTextController.text == '1'){
                        return;
                      }else {
                        setState(() {
                          _quantityTextController.text = (int.parse(_quantityTextController.text) -  1).toString();
                        });
                      }
                    }, icon: CupertinoIcons.minus, color: Colors.red),
                    const SizedBox(width: 5,),
                    Flexible(
                        flex: 1,
                        child: TextField(
                          controller: _quantityTextController,
                          key: const ValueKey('quantity'),
                          keyboardType: TextInputType.number,
                          maxLines: 1,
                          decoration: const InputDecoration(
                            border: UnderlineInputBorder(),
                          ),
                          textAlign: TextAlign.center,
                          cursorColor: Colors.green,
                          enabled: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp('[0-9]')),
                          ],
                          onChanged: (value) {
                            setState(() {
                              if (value.isEmpty) {
                                _quantityTextController.text = '1';
                              }else {}
                            });
                          },
                        )
                    ),
                    const SizedBox(width: 5,),
                    quantityController(fct: () {
                      setState(() {
                        _quantityTextController.text = (int.parse(_quantityTextController.text) + 1).toString();
                      });
                    }, icon: CupertinoIcons.plus, color: Colors.orangeAccent)
                  ],
                ),
                //************************************** End! *******************************************
                const SizedBox(height: 35, ),

                //************************************** Buy Code *******************************************
                Container(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        children: [
                          TextWidget(text: 'Total', color: Colors.black, textSize: 20, isTitle: true),
                          const SizedBox(height: 5,),
                          FittedBox(
                            child: Row(
                              children: [
                                Text("₹", style: Theme.of(context).textTheme.headline5!.copyWith(color: Colors.green),),
                                const SizedBox(width: 2,),
                                TextWidget(text: totalPrice.toStringAsFixed(2), color: Colors.green, textSize: 20, isTitle: true,),
                                TextWidget(text: '/ ₹${income.toStringAsFixed(2)}', color: Colors.black, textSize: 16, isTitle: false),
                              ],
                            ),
                          ),
                          const SizedBox(width: 18,),

                        ],
                      ),
                     // TextButton(onPressed: (){
                     //   GlobalMethods.orderProducts(
                     //       productId: productId,
                     //       price: getCurrProduct.price,
                     //       totalPrice: total,
                     //       quantity: int.parse(_quantityTextController.text),
                     //       imageUrl: getCurrProduct.imageUrl,
                     //       context: context);
                     // },
                     //   child: TextWidget(text: ' Investment  ', color: Colors.white, textSize: 18,),)
                      Flexible(
                          child: Material(
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10),
                            child: InkWell(
                              onTap: () async{
                                // final productProvider = Provider.of<ProductsProvider>(context, listen: false);
                                // final getCurrProduct = productProvider.findProdById(productId);
                                User? user = authInstance.currentUser;
                                final _uid = user!.uid;
                                final orderId = const Uuid().v4();
                                try {
                                  await FirebaseFirestore.instance.collection('orders').doc(_uid).set({
                                    'orderId': orderId,
                                    'userId': user.uid,
                                    'productId': productId,
                                    'price':  getCurrProduct.price, // (getCurrProduct.isOnSale ? getCurrProduct.salePrice : getCurrProduct.price) *  int.parse(_quantityTextController.text),
                                    'totalPrice' : total, // totalPrice,
                                    'quantity' : int.parse(_quantityTextController.text),
                                    'imageUrl' : getCurrProduct.imageUrl,
                                    'userName' : user.displayName,
                                    'complete' : "",
                                    'orderDate' : Timestamp.now(),
                                  });
                                  // ordersProvider.fetchOrders();
                                  await Fluttertoast.showToast(
                                      msg: "Thank you for your investment.",
                                      toastLength: Toast.LENGTH_SHORT,
                                    gravity: ToastGravity.CENTER,
                                  );
                                  launchUrl(orderLink);

                                }catch (error) {
                                    GlobalMethods.errorDialog(subtitle: error.toString(), context: context);
                                }finally {}
                              },

                              borderRadius: BorderRadius.circular(10),
                              child: Padding(
                                padding: const EdgeInsets.all(12.0),
                                child: TextWidget(
                                  text: ' Investment  ',
                                  color: Colors.white,
                                  textSize: 18,),
                              ),
                            ),
                          )
                      )
                    ],

                  ),
                ),
                //************************************** End! *******************************************
                const SizedBox(height: 15, ),
                //************************************** Description *******************************************
                const Padding(
                    padding: EdgeInsets.symmetric(vertical: 15),
                  child: Divider(height: 4,),
                ),
                TextWidget(text: 'Description', color: Colors.black, textSize: 22, isTitle: true,),
                const SizedBox(height: 10,),
                 ReadMoreText(
                   getCurrProduct.description,
                // 'Flutter is Google’s mobile UI open source framework to build high-quality native (super fast) interfaces for iOS '
                //     'and Android apps with the unified codebase.If you dont have the rupee icon, press Ctrl+Alt+4 keys togetherYou could also press the side Alt key (Alt_GR)+₹ symbol if it is available on your keyboard. The rupee symbol can also be added using the left side Alt key and then type 8377 on the numeric pad.',
                trimLines: 6,
                lessStyle: TextStyle(fontWeight: FontWeight.bold, color: Colors.red, fontSize: 14),
                // colorClickableText: Colors.yellow,
                  style: TextStyle(fontSize: 15, color: Colors.grey),
                trimMode: TrimMode.Line,
                trimCollapsedText: 'Show more',
                trimExpandedText: 'Show less',
                 moreStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold, color: Colors.green),
                 ),
                //************************************** End! **************************************
              ],
            ),
          ),
        );
      }
    );
  }



  Widget quantityController({required Function fct, required IconData icon, required Color color}) {
    return Flexible(
        flex: 2,
        child: Material(
          borderRadius: BorderRadius.circular(12),
          color: color,
          child: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () {
              fct();
            },
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Icon(icon, color: Colors.white, size: 25,
              ),
            ),
          ),
        )
    );
  }
}