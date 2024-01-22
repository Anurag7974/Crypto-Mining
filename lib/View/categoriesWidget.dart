// import 'package:btcmining/View/Components/text_widget.dart';
// import 'package:flutter/material.dart';
//
// import '../signupLogin/screen/inner_screen/product_details.dart';
//
// class CategoriesWidget extends StatelessWidget {
//   const CategoriesWidget(
//       {Key? key,
//         required this.catText,
//         required this.imgPath,
//         required this.passeColor})
//       : super(key: key);
//   final String catText, imgPath;
//   final Color passeColor;
//
//   @override
//   Widget build(BuildContext context) {
//     double _screenWidth = MediaQuery.of(context).size.width;
//     return InkWell(
//       onTap: () {
//         Navigator.push(context, MaterialPageRoute(builder: (context) => const ProductDetails()));
//         // print('object');
//       },
//       child: Container(
//         // height: _screenWidth * 0.6,
//         decoration: BoxDecoration(
//           color: passeColor.withOpacity(0.1),
//           borderRadius: BorderRadius.circular(16),
//           border: Border.all(color: passeColor.withOpacity(0.7), width: 2),
//         ),
//         child: Column (
//           children: [
//             Container(
//               height: _screenWidth * 0.3,
//               width: _screenWidth * 0.3,
//               decoration: BoxDecoration(
//                   image: DecorationImage(image: AssetImage(imgPath,),
//                       fit: BoxFit.fill)),
//             ),
//             TextWidget(
//               text: catText,
//               color: Colors.black,
//               textSize: 20,
//               isTitle: true,
//             ),
//           ],
//         ),
//       ),
//     );
//   }
//
// }