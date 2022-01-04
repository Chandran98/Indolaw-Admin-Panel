import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/main.dart';
import 'package:panel/routes/routes.dart';
import 'package:panel/services/sidebar.dart';

class Notificationscreen extends StatefulWidget {
  Notificationscreen({Key? key}) : super(key: key);
static const String id ="Notification";

  @override
  _NotificationscreenState createState() => _NotificationscreenState();
}

class _NotificationscreenState extends State<Notificationscreen> {
  SidebarWidget sidebarWidget = SidebarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
        appBar: AppBar(
          backgroundColor: dialog,
          title: const Text("Admin Dashboard"),
        ),
        body: const Align(alignment: Alignment.topLeft,
          child: Text("Notifications"),
        ),
        sideBar: sidebarWidget.Sidebarmenu(context, notificationroute));
  }
}