import 'package:flutter/material.dart';

class ProductModel with ChangeNotifier{
  final String id, title, imageUrl, productCategoryName, description, income, cycleDays ;
  final double price, salePrice;
  final bool isOnSale, isDouble;

  ProductModel ({
    required this.id,
    required this.title,
    required this.description,
    required this.income,
    required this.cycleDays,
    required this.imageUrl,
    required this.productCategoryName,
    required this.price,
    required this.salePrice,
    required this.isOnSale,
    required this.isDouble,

  });
}