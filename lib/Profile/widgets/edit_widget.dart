// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
//
// import '../../services/global_method.dart';
// import '../../services/utils.dart';
//
// class EditWidgetScreen extends StatefulWidget {
//   const EditWidgetScreen({Key? key, required this.id,}) : super(key: key);
//   final String id;
//   @override
//   _EditWidgetState createState() => _EditWidgetState();
//
// }
//
// class _EditWidgetState extends State<EditWidgetScreen>{
//   String name = '';
//   String email = '';
//   String? imageUrl;
//   String phone = '';
//   String password = '';
//   // bool isOnSale = false;
//   // bool isPiece = false;
//
//   @override
//   void initState() {
//     getProductData();
//     super.initState();
//   }
//
//   Future<void> getProductData() async {
//     try {
//       final DocumentSnapshot productsDoc = await FirebaseFirestore.instance.collection('products').doc(widget.id).get();
//       if (productsDoc == null) {
//         return;
//       } else {
//         setState(() {
//           name = productsDoc.get('name');
//           email = productsDoc.get('email');
//           imageUrl = productsDoc.get('imageUrl');
//           phone = productsDoc.get('phone');
//           password = productsDoc.get('password');
//
//         });
//       }
//     } catch (error) {
//       GlobalMethods.errorDialog(subtitle: '$error', context: context);
//     } finally {}
//   }
//   @override
//   Widget build(BuildContext context) {
//     Size size = Utils(context).getScreenSize;
//     final color = Utils(context).color;
//
//     return Padding(
//         padding: const EdgeInsets.all(8.0),
//         child: Material(
//           borderRadius: BorderRadius.circular(12),
//           color: Theme.of(context).cardColor.withOpacity(0.6),
//           child: InkWell(
//               borderRadius: BorderRadius.circular(12),
//               onTap: () {
//                 Navigator.of(context).push(MaterialPageRoute(builder: (context) => EditProductScreen(
//                   id: widget.id,
//                   title: title,
//                   price: price,
//                   salePrice: salePrice,
//                   productCat: productCat,
//                   imageUrl:
//                   imageUrl == null?
//                   'https://media.istockphoto.com/id/185284489/photo/orange.webp?b=1&s=170667a&w=0&k=20&c=a9rTa5lUsFBIz3RkL-dTXZV3oa9iRmP1lMVyTPoPA60='
//                       : imageUrl!,
//                   isOnSale: isOnSale,
//                   isPiece: isPiece,
//                 )));
//               },
//               child: Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                         crossAxisAlignment: CrossAxisAlignment.start,
//                         children: [
//                           Flexible(
//                             flex: 3,
//                             child: Image.network(
//                               imageUrl == null ?
//                               'https://media.istockphoto.com/id/185284489/photo/orange.webp?b=1&s=170667a&w=0&k=20&c=a9rTa5lUsFBIz3RkL-dTXZV3oa9iRmP1lMVyTPoPA60='
//                                   : imageUrl!,
//                               fit: BoxFit.fill,
//                               height: size.width * 0.12,
//                             ),
//                           ),
//                           const Spacer(),
//                           PopupMenuButton(
//                               itemBuilder: (context) => [
//                                 PopupMenuItem(
//                                   onTap: () {},
//                                   value: 1,
//                                   child: const Text('Edit'),
//                                 ),
//                                 PopupMenuItem(
//                                   onTap: () {},
//                                   value: 1,
//                                   child: const Text('Delete', style: TextStyle(color: Colors.red),),
//                                 )
//                               ])
//                         ],
//                       ),
//                       const SizedBox(height: 2,),
//                       Row(
//                         children: [
//                           TextWidget(text: isOnSale ? '\$${salePrice.toStringAsFixed(2)}' : '\$$price',
//                             color: color, textSize: 10,),
//                           const SizedBox(width: 7,),
//                           Visibility(
//                             visible: isOnSale,
//                             child: Text('\$$price',
//                               style: TextStyle(decoration: TextDecoration.lineThrough, color: color),),
//                           ),
//                           const Spacer(),
//                           TextWidget(text: isPiece ? 'Piece' : '1Kg', color: color, textSize: 18,),
//                         ],),
//                       const SizedBox(height: 2,),
//                       TextWidget(text: title, color: color, textSize: 20, isTitle: true)
//                     ],
//                   )
//               )
//
//           ),
//         )
//     );
//   }
//
// }