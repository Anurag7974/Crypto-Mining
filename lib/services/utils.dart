import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../provider/dart_theme_provider.dart';

class Utils {
  BuildContext context;
  Utils(this.context);
  bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
  Size get getScreenSize => MediaQuery.of(context).size;
  Color get color =>   Colors.black;
  // bool get getTheme => Provider.of<DarkThemeProvider>(context).getDarkTheme;
}