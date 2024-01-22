import 'package:btcmining/View/Components/text_widget.dart';
import 'package:btcmining/services/utils.dart';
import 'package:fancy_shimmer_image/fancy_shimmer_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_iconly/flutter_iconly.dart';

class ProductDetails extends StatefulWidget {
  static const routeName = '/ProductDetails';

  const ProductDetails({Key? key}) : super(key: key);

  @override
  _ProductDetailsState createState() => _ProductDetailsState();

}

class _ProductDetailsState extends State<ProductDetails>{
  final _quantityTextController = TextEditingController(text: '1');

  @override
  void dispose(){
  //  Clean up the controller when the widget is disposed.
    _quantityTextController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
      Size size = Utils(context).getScreenSize;
      final Color color = Utils(context).color;

      return Scaffold(
        // ************************************************ Apps Bar Code ****************************************************
        appBar: AppBar(
          leading: InkWell(
            borderRadius: BorderRadius.circular(12),
            onTap: () => Navigator.canPop(context) ? Navigator.pop(context) : null,
            child: Icon(
              IconlyLight.arrowLeft2, color: color, size: 24,
            ),
          ),
          elevation: 0,
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        ),
        //************************************** End! ***********************************************
        body: Column(children: [
          Flexible(
            flex: 2,
            child: FancyShimmerImage(
              imageUrl: 'https://pngimg.com/uploads/bitcoin/small/bitcoin_PNG37.png',
              boxFit: BoxFit.scaleDown,
              width: size.width,
            ),
          ),
             //************************************** Half Cart Code ***********************************************
          Flexible(
            flex: 3,
            child: Container(
              decoration: BoxDecoration(
                color: Theme.of(context).cardColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(40),
                  topRight: Radius.circular(40),
              )
            ),
              //************************************** End! ***********************************************
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Flexible(
                          child: TextWidget(text: 'title', color: color, textSize: 25, isTitle: true,)
                      ),
                      Icon(IconlyLight.buy, size: 22, color: color,)
                    ],
                   ),
                  ),
                  Padding(
                      padding: const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(text: 'INR 100000.59', color: Colors.orangeAccent, textSize: 22, isTitle: true,),
                        TextWidget(text: '/per', color: color, textSize: 15, isTitle: false,),
                        const SizedBox(width: 10,),
                        Visibility(
                            visible: true,
                            child: Text(
                              'INR 300000.9',
                              style: TextStyle(fontSize: 15, color: color, decoration: TextDecoration.lineThrough),)
                            ),
                        const Spacer(),
                        // Container(
                        //   padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                        //   decoration: BoxDecoration(
                        //     color: Colors.orangeAccent,
                        //     borderRadius: BorderRadius.circular(5),
                        // ),
                        //   child: TextWidget(text: 'Coins', color: Colors.white, textSize: 20, isTitle: true,)),
                      ],
                    ),
                  ),
                  // const SizedBox(height: 30,),
                  Padding(
                    padding:const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(text: 'INR 80/Per day = 30 days.', color: Colors.black87, textSize: 20),
                      ],
                    ),
                  ),
                  Padding(
                    padding:const EdgeInsets.only(top: 20, left: 30, right: 30),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        TextWidget(text: 'Credited in you wallet.', color: Colors.black87, textSize: 20),
                        // TextWidget(text: 'Credited in you wallet.', color: Colors.black87, textSize: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 30,),
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
                  const Spacer(),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                    decoration: const BoxDecoration(
                      color: Colors.orangeAccent,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(20),
                        topLeft: Radius.circular(20),
                      ),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Flexible(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                TextWidget(text: 'Total', color: Colors.red, textSize: 20, isTitle: true),
                                const SizedBox(height: 5,),
                                FittedBox(
                                  child: Row(
                                    children: [
                                      TextWidget(text: 'INR 1000.59', color: color, textSize: 20, isTitle: true,),
                                      TextWidget(text: '/${_quantityTextController.text}Per', color: color, textSize: 16, isTitle: false),
                                    ],
                                  ),
                                )
                              ],
                            )
                        ),
                        const SizedBox(width: 8,),
                        Flexible(
                            child: Material(
                              color: Colors.red,
                              borderRadius: BorderRadius.circular(10),
                              child: InkWell(
                                onTap: () {},
                                borderRadius: BorderRadius.circular(10),
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: TextWidget(
                                    text: ' BUY NOW  ',
                                    color: Colors.white,
                                    textSize: 18,),
                                ),
                              ),
                            )
                        )
                      ],
                    ),
                  )
                ],
              ),
            )
          ),
        ],),
      );
  }
  Widget quantityController(
      {required Function fct, required IconData icon, required Color color}) {
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