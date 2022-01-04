import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/routes/routes.dart';
import 'package:panel/services/sidebar.dart';

class Mainscreen extends StatefulWidget {
  const Mainscreen({Key? key}) : super(key: key);

  static const String id = "mainscreen";

  @override
  _MainscreenState createState() => _MainscreenState();
}

class _MainscreenState extends State<Mainscreen> {
  SidebarWidget sidebarWidget = SidebarWidget();

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: dialog,
          title: const Text("Admin Dashboard"),
        ),
        body: const Align(
          alignment: Alignment.topLeft,
          child: Text("Dashboard"),
        ),
        sideBar: sidebarWidget.Sidebarmenu(context, mainscreenroute));
  }
}
