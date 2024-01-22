// import 'package:flutter/material.dart';
// import 'package:flutter_iconly/flutter_iconly.dart';
//
// import 'Components/text_widget.dart';
// import 'categoriesWidget.dart';
//
// class CategoriesPage extends StatelessWidget {
//   CategoriesPage({Key? key}) : super(key: key);
//
//   List<Map<String, dynamic>> catInfo = [
//     {
//       'imgPath': 'assets/coin/bitcoin.png',
//       'catText': 'Bitcoin'
//     },
//     {
//       'imgPath': 'assets/coin/ethereum.png',
//       'catText': 'Ethereum'
//     },
//     {
//       'imgPath': 'assets/coin/tether.png',
//       'catText': 'Tether'
//     },
//     {
//       'imgPath': 'assets/coin/binancecoin.png',
//       'catText': 'Binance coin'
//     },
//     {
//       'imgPath': 'assets/coin/Ripple.png',
//       'catText': 'Ripple'
//     },
//     {
//       'imgPath': 'assets/coin/usd-coin.png',
//       'catText': 'usd-coin'
//     },
//   ];
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       //********************** App Bar Code ***********************************************
//         appBar: AppBar(
//           leading: InkWell(
//             borderRadius: BorderRadius.circular(12),
//             onTap: () {
//               Navigator.pop(context);
//             },
//             child: const Icon(
//               IconlyLight.arrowLeft2,
//               color:  Colors.black87,
//             ),
//           ),
//           elevation: 0,
//           backgroundColor: const Color(0xffFBC700),
//           title: TextWidget(text: 'Products on sale', color:  Colors.black87, textSize: 22.0, isTitle: true,),
//         ),
//         //********************** End Code ***********************************************
//         body: Padding(
//           padding: const EdgeInsets.all(8.0),
//           child: GridView.count(
//             crossAxisCount: 2,
//             childAspectRatio: 230/250,
//             crossAxisSpacing: 15, // Vertical Spacing
//             mainAxisSpacing: 15, // Horizontal Spacing
//             children: List.generate(6, (index){
//               return CategoriesWidget(
//                 catText: catInfo[index]['catText'],
//                 imgPath: catInfo[index]['imgPath'],
//                 passeColor: const Color(0xffFBC700),);
//             }),
//        ),
//         )
//     );
//   }
// }