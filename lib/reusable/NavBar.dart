import 'dart:math';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:notes/controlles/LogOutController.dart';
import 'package:notes/helpers/SharedPreferencesManager.dart';
import 'package:notes/screens/LogIn.dart';

class NavBar extends StatefulWidget {
  @override
  State<NavBar> createState() => _NavBarState();
}

class _NavBarState extends State<NavBar> {
  String? email = SharedPreferencesManager.getString('email');

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text('Ali Mohamed'),
            accountEmail: Text(email!),
            currentAccountPicture: CircleAvatar(
              backgroundImage: AssetImage("assets/images/facebook.jpg"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.home),
            title: Text("homepage").tr(),
            onTap: () {
              Navigator.pop(context);

            },
          ),
          ListTile(
            leading: Icon(Icons.language),
            title: Text("change language").tr(),
            onTap: () {
              changeLanguage();
              Navigator.pop(context); // Close the drawer
            },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text("logout").tr(),
            onTap: () async {
              dynamic auth_token = SharedPreferencesManager.getString('token');
              await LogOutController().logout(auth_token);
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => LogIn()));
            },
          ),
        ],
      ),
    );
  }

  changeLanguage() {
    String currentLang = context.locale.toString();

      if (currentLang == "en") {
        context.setLocale(const Locale('ar'));
      } else {
        context.setLocale(const Locale('en'));

      }

  }
}
