import 'package:btcmining/View/all_products.dart';
import 'package:btcmining/View/navBar.dart';
import 'package:btcmining/provider/orders_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:provider/provider.dart';

import '../../Login_Pages/consts/contss.dart';
import '../../provider/products_provider.dart';

class FetchScreen extends StatefulWidget {
  const FetchScreen({Key? key}) : super(key: key);

  @override
  State<FetchScreen> createState() => _FetchScreenState();
}

class _FetchScreenState extends State<FetchScreen>{
  List<String> images = Constss.authImagesPaths;
  @override
  void initState() {
    images.shuffle();
    Future.delayed(const Duration(milliseconds: 5), () async{
      final productsProvider = Provider.of<ProductsProvider>(context);
      await productsProvider.fetchProducts();
      final orderProvider = Provider.of<OrdersProvider>(context);
      Navigator.of(context).pushReplacement(MaterialPageRoute(builder: (ctx) => const NavBar()));
    });
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset('assets/background/screen4.png', fit: BoxFit.cover, height: double.infinity,),
          Container(color: Colors.black.withOpacity(0.7),),
          const Center(
            child: SpinKitFadingFour(
              color: Colors.white,
            ),)
        ],
      ),
    );
  }

}