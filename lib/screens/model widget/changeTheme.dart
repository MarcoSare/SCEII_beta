
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:sceii/provider/theme_provider.dart';

import '../../utils/appSimplePreferences.dart';

class ChangeThemeButton extends StatelessWidget{
  appPreferences app_preferences = appPreferences();

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Switch.adaptive(
      value: themeProvider.isDarkMode,
     onChanged: (bool value) async {
        await app_preferences.setTheme(value);
        final provider = Provider.of<ThemeProvider>(context, listen: false);
        provider.toggleTheme(value);
     },);
  }
}