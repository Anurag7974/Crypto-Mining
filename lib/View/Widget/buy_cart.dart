import 'package:flutter/cupertino.dart';
import 'package:flutter_iconly/flutter_iconly.dart';
import 'package:provider/provider.dart';

import '../../services/utils.dart';

class BuyCart extends StatelessWidget {
  const BuyCart({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Color color = Utils(context).color;
    return GestureDetector(
      onTap: () {
        print('print heart button is pressed');
      },
      child: Icon(
        IconlyLight.buy,
        size: 22,
        color: color,
      ),
    );
  }
}