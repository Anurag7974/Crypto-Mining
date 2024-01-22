import 'package:btcmining/services/utils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../../View/Components/text_widget.dart';
import '../../../View/Widget/on_sale_widget.dart';
import '../../../View/backWidget.dart';
import '../../../constants/text_strings.dart';
import '../../../View/Model/products_model.dart';
import '../../../provider/products_provider.dart';

class OnSaleScreen extends StatelessWidget {
  static const routeName = "/OnSaleScreen";
  const OnSaleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = Utils(context).getScreenSize;
    final productProviders = Provider.of<ProductsProvider>(context);
    List<ProductModel> productsOnSale = productProviders.getOnSaleProducts;
    return Scaffold(
      appBar: AppBar(
        leading: const BackWidget(),
        elevation: 2,
        backgroundColor: const Color(0xFFFFE400),
        centerTitle: true,
        title: Text("Coins on offers", style: Theme.of(context).textTheme.headline5,),
        // title: TextWidget(text: tEditProfile, color: Colors.black87, textSize: 25.0, isTitle: true, ),
      ),
      body: productsOnSale.isEmpty ? Center(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.all(18.0),
                child: Image.asset('assets/splash/box-removebg-preview.png'),
              ),
              const Text('No products on sale yet,! \nStay tuned',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.black, fontSize: 40, fontWeight: FontWeight.w700),),
            ],
          ),
        ),
      ) : GridView.count(
        crossAxisCount: 2,
        padding: EdgeInsets.zero,
        // crossAxisSpacing: 10,
        childAspectRatio: size.width / (size.height * 0.45),
        children: List.generate(productsOnSale.length, (index) {
          return ChangeNotifierProvider.value(
              value: productsOnSale[index],
              child: const OnSaleWidget());
        }),
      ),
    );
  }
}
