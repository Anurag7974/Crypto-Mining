import 'package:btcmining/View/Components/item2.dart';
import 'package:flutter/material.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:http/http.dart' as http;
import '../Model/coinModel.dart';
import 'Banners/images_slider.dart';
import 'Components/item.dart';
import 'Components/text_widget.dart';


class Home extends StatefulWidget {
  static const routeName = "/Home";
  const Home({super.key});

  @override
  State<StatefulWidget> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    getCoinMarket();
    super.initState();
  }

  Widget build(BuildContext context) {
    double myHeight = MediaQuery.of(context).size.height;
    double myWidth = MediaQuery.of(context).size.width;
    return WillPopScope(
      onWillPop: () async{
       final value =  await showDialog<bool>(
           context: context,
           builder: (context) {
          return AlertDialog(
            title: const Text('Alert'),
            content: const Text('Do you want to Exit'),
            actions: [
              ElevatedButton(onPressed: ()=> Navigator.of(context).pop(false), child: const Text('No')),
              ElevatedButton(onPressed: ()=> Navigator.of(context).pop(true), child: const Text('Exit')),
            ],
          );
        });
       if(value != null) {
         return Future.value(value);
       } else {
         return Future.value(false);
       }
      },
      child: Scaffold(
        //********************** App Bar Code ***********************************************
        // appBar: AppBar(
        //   leading: InkWell(
        //     borderRadius: BorderRadius.circular(12),
        //     onTap: () {
        //       Navigator.pop(context);
        //     },
        //     child: const Icon(
        //       IconlyLight.arrowLeft2,
        //       color:  Colors.black87,
        //     ),
        //   ),
        //   elevation: 0,
        //   backgroundColor: const Color(0xffFBC700),
        //   title: TextWidget(text: 'Products on sale', color:  Colors.black87, textSize: 24.0, isTitle: true,),
        // ),
        //********************** End Code ***********************************************
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(
                height: myHeight * 0.30,
                child: const ImageSlider(),
                    ),
                    //-------------------------------------------- END! ----------------------------------------------//
                    // SizedBox(height: myHeight * 0.02,),
                    Container(
                      height: myHeight * 0.3,
                      width: myWidth,
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(blurRadius: 5, color: Colors.grey.shade200, spreadRadius: 3, offset: const Offset(0, 3))
                        ],
                          color: Colors.white,
                          borderRadius: const BorderRadius.only(topLeft: Radius.circular(50), topRight: Radius.circular(50),
                          )),
                      child: Column(
                        children: [
                          SizedBox(height: myHeight * 0.05,),
                            Padding(
                              padding: EdgeInsets.symmetric(horizontal: myWidth * 0.06),
                              child: const Row(
                                children: [
                                  Text('Recommend to Buy', style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),),
                                ],
                              ),
                            ),
                          SizedBox(height: myHeight * 0.02,),
                          Expanded(
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: myWidth * 0.03),
                              child: isRefreshing == true ?
                              const Center(child: CircularProgressIndicator(color: Color(0xffFBC700),),
                              ) :
                              coinMarket == null || coinMarket!.length == 0
                                  ?Padding(
                                    padding: EdgeInsets.all(myHeight * 0.06),
                                      child: const Center(child: Text('Your Internet speed is very low, please wait and try again later.',
                                      style: TextStyle(fontSize: 18),),),
                              )
                               : ListView.builder(
                                scrollDirection: Axis.horizontal,
                                itemCount: coinMarket!.length,
                                itemBuilder: (context, index){
                                  return Item2(item: coinMarket![index],);
                                },
                              ),
                            ),
                          ),
                          SizedBox(height: myHeight * 0.01,),
                        ],
                      ),
                    ),
              SizedBox(height: myHeight * 0.03,),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: myWidth * 0.08),
                child: const Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text('Assets', style: TextStyle(fontSize: 16),),
                    // Icon(Icons.add)
                  ],
                ),
              ),
              SizedBox(height: myHeight * 0.02,),
              Container(
                height: myHeight * 0.36,
                child:   isRefreshing == true ?
                  const Center(child: CircularProgressIndicator(color: Color(0xffFBC700),),
                  ) :
                  coinMarket == null || coinMarket!.length == 0
                      ?Padding(
                        padding: EdgeInsets.all(myHeight * 0.06),
                        child: const Center(child: Text('Your Internet speed is very low, please wait and try again later.',
                        style: TextStyle(fontSize: 18),),),
                         ) :
                      SingleChildScrollView(
                        child: ListView.builder(itemCount: 60, shrinkWrap: true, physics: const NeverScrollableScrollPhysics(), itemBuilder: (context, index) {
                          return Item(item: coinMarket![index],
                          );
                        },
                    ),
                      ),
              ),
                  ],
                ),
              ),
          ),
    );
  }

  bool isRefreshing = true;

  List? coinMarket = [];
  var coinMarketList;
  Future<List<CoinModel>?> getCoinMarket() async {
    const url = 'https://api.coingecko.com/api/v3/coins/markets?vs_currency=eur&order=market_cap_desc&per_page=100&page=1&sparkline=true';

    setState(() {
      isRefreshing = true;
    });
    var response = await http.get(Uri.parse(url), headers: {
      "Content-Type" : "application/json",
      "Accept" : "application/json",
    });
    setState(() {
      isRefreshing = false;
    });
    if(response.statusCode == 200){
      var x = response.body;
      coinMarketList = coinModelFromJson(x);
      setState(() {
        coinMarket = coinMarketList;
      });
    }else{
        print(response.statusCode);
    }
  }

}