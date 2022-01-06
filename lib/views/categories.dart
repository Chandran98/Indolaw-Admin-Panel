import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/main.dart';
import 'package:panel/routes/routes.dart';
import 'package:panel/services/sidebar.dart';
import 'package:panel/widgets/caetgory/category_list.dart';
import 'package:panel/widgets/caetgory/category_upload.dart';

class Category extends StatefulWidget {
  // static const String id = "Category";

  Category({Key? key}) : super(key: key);

  @override
  _CategoryState createState() => _CategoryState();
}

class _CategoryState extends State<Category> {
  SidebarWidget sidebarWidget = SidebarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: dialog,
        title: const Text("Admin Dashboard"),
      ),
      sideBar: sidebarWidget.Sidebarmenu(context, categoryroute),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Category",
                style: header,
              ),
              Text(
                "Add and Manage categories",
                style: textfont,
              ),
              divider,
              const Uploadcategory(),divider,
              Categorylist()
            ],
          ),
        ),
      ),
    );
  }
}
