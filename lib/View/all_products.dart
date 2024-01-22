import 'package:btcmining/View/Model/products_model.dart';
import 'package:btcmining/provider/products_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:line_awesome_flutter/line_awesome_flutter.dart';
import 'package:provider/provider.dart';

import '../services/global_method.dart';
import 'About/about.dart';
import 'News/news_Screen.dart';
import 'News/news_Widgets.dart';
import '../signupLogin/screen/inner_screen/on_sale_screen.dart';
import '../services/utils.dart';
import 'Components/text_widget.dart';
import 'Widget/feed_items.dart';
import 'Widget/on_sale_widget.dart';
import 'backWidget.dart';

class AllProducts extends StatefulWidget {
  static const routeName = "/AllProducts";
  const AllProducts({Key? key}) : super(key: key);

  @override
  State<AllProducts> createState() => _AllProductsState();
}

class _AllProductsState extends State<AllProducts> {
  final TextEditingController? _searchTextController = TextEditingController();
  final FocusNode _searchTextFocusNode = FocusNode();
  @override
  void dispose(){
    _searchTextController!.dispose();
    _searchTextFocusNode.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> allProducts = productProviders.getProducts;
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    return Scaffold(
      //********************** App Bar Code ***********************************************
      appBar: AppBar(
        leading:const Icon(LineAwesomeIcons.hand_pointing_right,color: Colors.red, size: 35,),
        toolbarHeight: 80,
        elevation: 1,
        backgroundColor: Colors.white,//const Color(0xffFBC700),
        title: Row(
          children: [
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/splash/about-removebg-preview.png"),
            ),
            TextButton(onPressed: (){
              GlobalMethods.navigateTo(ctx: context, routeName: AboutScreen.routeName);
            },
                child: Text("About Us", style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),)),
            const Spacer(),
            const CircleAvatar(
              radius: 20,
              backgroundImage: AssetImage("assets/splash/notice-removebg-preview.png"),
            ),
            const SizedBox(width: 5,),
            TextButton(onPressed: (){
              GlobalMethods.navigateTo(ctx: context, routeName: NewsScreen.routeName);
            },
                child: Text("News List", style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),)),
          ],
        ),
      ),
      //********************** End Code ***********************************************
      body: SingleChildScrollView(
        child: Column(children: [
          // const Padding(
          //   // padding: EdgeInsets.only(right: 400000),
          // ),
          TextButton(onPressed: () {
            // Navigator.push(context, MaterialPageRoute(builder: (context) => const OnSaleScreen()),);
            GlobalMethods.navigateTo(ctx: context, routeName: OnSaleScreen.routeName);
            }, child: Padding(
            padding: const EdgeInsets.only(left: 286.0),
            child: TextWidget(
              text: 'View all', maxLines: 1, color: Colors.red, textSize: 20,
            ),
          )),
          Row(
            children: [
              const SizedBox(width: 6,),
              RotatedBox(
                quarterTurns: -1,
                child: Row(
                  children: [
                    TextWidget(text: 'On offers'.toUpperCase(), color: Colors.red, textSize: 22, isTitle: true,),
                    const SizedBox(width: 5,),
                    const Icon(IconlyLight.discount, color: Colors.red,),
                  ],
                ),
              ),
              const SizedBox(width: 8,),
                  Flexible(
                      child: SizedBox(
                        height: size.height*0.25,
                        // width: size.width*0.65,
                        child:  ListView.builder(
                          itemCount: productsOnSale.length < 10 ? productsOnSale.length : 10,
                          scrollDirection: Axis.horizontal,
                          itemBuilder: (ctx, index){
                            return ChangeNotifierProvider.value(
                                value: productsOnSale[index],
                                child:  const OnSaleWidget());
                          }
                        ),
                      ),
                    ),
                  ],
                ),
          const SizedBox(height: 10,),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                TextWidget(text: 'Our products', color: color, textSize: 22, isTitle: true),
              ],),
          ),
          // const Padding(
          //   padding: EdgeInsets.all(8.0),
          //********************** Search Code ***********************************************
            // child: SizedBox(
            //   height: kBottomNavigationBarHeight,
            //   child: TextField(
            //     focusNode: _searchTextFocusNode,
            //     controller: _searchTextController,
            //     onChanged: (valuee) {
            //       setState(() {
            //
            //       });
            //     },
            //     decoration: InputDecoration(
            //       focusedBorder: OutlineInputBorder(
            //         borderRadius: BorderRadius.circular(12),
            //           borderSide: const BorderSide(color: Color(0xffFBC700), width: 1)),
            //       enabledBorder: OutlineInputBorder(
            //           borderRadius: BorderRadius.circular(12),
            //           borderSide: const BorderSide(color: Color(0xffFBC700), width: 1)),
            //       hintText: "What's in your mind",
            //       prefixIcon: const Icon(Icons.search),
            //         suffix: IconButton(
            //           onPressed: () {
            //             _searchTextController!.clear();
            //             _searchTextFocusNode.unfocus();
            //           },
            //           icon: Icon(Icons.close,
            //               color: _searchTextFocusNode.hasFocus ? Colors.red : color),
            //         )
            //     )
            //   ),
            // ),
            //********************** End Code! ***********************************************
          // ),
          GridView.count(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            crossAxisCount: 1,
            padding: EdgeInsets.zero,// Vertical Spacing
            childAspectRatio: size.width / (size.height * 0.3),// Horizontal Spacing
            children: List.generate( allProducts.length <= allProducts.length ? allProducts.length : allProducts.length, (index){
              return ChangeNotifierProvider.value(
                value: allProducts[index],
                child: const FeedsWidget(),
              );
            }),
          ),
        ],),
      ),
    );
  }

}