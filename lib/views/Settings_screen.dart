import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/main.dart';
import 'package:panel/routes/routes.dart';
import 'package:panel/services/sidebar.dart';

class Settingsscreen extends StatefulWidget {
  Settingsscreen({Key? key}) : super(key: key);
  static const String id = "settingssceen";

  @override
  _SettingsscreenState createState() => _SettingsscreenState();
}

class _SettingsscreenState extends State<Settingsscreen> {
  SidebarWidget sidebarWidget = SidebarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: dialog,
          title: const Text("Admin Dashboard"),
        ),
        body: const Align(
          alignment: Alignment.topLeft,
          child: Text("Settings"),
        ),
        sideBar: sidebarWidget.Sidebarmenu(context, settingsroute));
  }
}
