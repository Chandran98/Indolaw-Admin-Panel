import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/main.dart';
import 'package:panel/routes/routes.dart';
import 'package:panel/services/sidebar.dart';

class Caseorder extends StatefulWidget {
  static const String id = "Caseorder";

  Caseorder({Key? key}) : super(key: key);

  @override
  _CaseorderState createState() => _CaseorderState();
}

class _CaseorderState extends State<Caseorder> {
  SidebarWidget sidebarWidget = SidebarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      
        appBar: AppBar(
          backgroundColor: dialog,
          title: const Text("Admin Dashboard"),
        ),
        body: const Align(alignment: Alignment.topLeft,
          child: Text("Cases & Orders"),
        ),
        sideBar: sidebarWidget.Sidebarmenu(context, casesorderroute));
  }
}
