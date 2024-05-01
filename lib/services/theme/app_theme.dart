import 'package:flutter/material.dart';

class AppTheme {
  static final ThemeData _lightTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF07167),
      primary: const Color(0xFFF07167),
      secondary: const Color(0xFFFED9B7),
      brightness: Brightness.light,
    ),
    cardColor: Colors.white,
    scaffoldBackgroundColor: Colors.white,
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF4e4e5a),
      iconTheme: IconThemeData(
        color: Color(0xFFF07167),
      ),
    ),
    fontFamily: 'Montserrat',
  );

  static final ThemeData _darkTheme = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: const Color(0xFFF07167),
      primary: const Color(0xFFF07167),
      secondary: const Color(0xFFFED9B7),
      brightness: Brightness.dark,
    ),
    cardColor: const Color(0xFF4e4e5a),
    scaffoldBackgroundColor: const Color(0xFF232331),
    appBarTheme: const AppBarTheme(
      backgroundColor: Color(0xFF1f1f2c),
      iconTheme: IconThemeData(
        color: Color(0xFFFED9B7),
      ),
      centerTitle: true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(25),
          bottomRight: Radius.circular(25),
        ),
      ),
    ),
    fontFamily: 'Montserrat',
  );

  static ThemeData getTheme(bool isDark) {
    return isDark ? _darkTheme : _lightTheme;
  }
}

class AppColors {
  static const Color primaryBlack = Color(0xFF232331);
  static const Color splashColor = Color(0xFFE9FAFF);
  static const Color loginTextFieldColor = Color(0xFFF1F5FB);
  static const Color redColor = Color(0xFFD42A0F);
  static const Color greenColor = Color(0xFF29D40F);
  static const Color darkGreen = Color(0xFF004F62);
  static const Color greyColor = Color(0xFF808080);
  static const Color darkGreyColor = Color(0xFF707070);
  static const Color dividerColor = Color(0xFFC7C7C7);
  static const Color lightGreen = Color(0xFFCBFFCB);

  static const Color greenBorder = Color(0xFF39A238);
  static const Color blueBorder = Color(0xFF0A3F8F);
}


// Color scafoldBackgroundColor = Color(0xFF232331);
// Color scafoldBackgroundColorLight1 = Color(0xFF383845);
// Color scafoldBackgroundColorLight2 = Color(0xFF4e4e5a);
// Color scafoldBackgroundColorLight3 = Color(0xFF65656e);
// Color scafoldBackgroundColorLight4 = Color(0xFF7b7b83);
// Color scafoldBackgroundColorDark1 = Color(0xFF1f1f2c);
// Color primaryColor = Color(0xFFF07167);
// Color primaryColorLight1 = Color(0xFFf17f76);
// Color primaryColorLight2 = Color(0xFFf38d85);
// Color secondaryColor = Color(0xFFFED9B7);
// Color secondaryColorLight1 = Color(0xFFfedcbe);
// Color secondaryColorLight2 = Color(0xFFfee0c5);
