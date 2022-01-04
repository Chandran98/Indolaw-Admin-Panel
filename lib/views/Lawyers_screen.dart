import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/routes/routes.dart';
import 'package:panel/services/sidebar.dart';
import 'package:panel/widgets/Lawyers/lawyer_datatable.dart';

class Lawyerscreen extends StatefulWidget {
  static const String id = "Lawyerscreen";

  Lawyerscreen({Key? key}) : super(key: key);

  @override
  _LawyerscreenState createState() => _LawyerscreenState();
}

class _LawyerscreenState extends State<Lawyerscreen> {
  SidebarWidget sidebarWidget = SidebarWidget();

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      appBar: AppBar(
        backgroundColor: dialog,
        title: const Text("Admin Dashboard"),
      ),
      sideBar: sidebarWidget.Sidebarmenu(context, lawyerscreenroute),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Lawyers Dashboard",
                style: header,
              ),
              Text(
                "Manage Lawyers",
                style: textfont,
              ),
              // const Divider(
              //   thickness: 5,
              // ),
              // const Lawyerflilter(),
              const Divider(
                thickness: 5,
              ),
              const Lawyertable(),
            ],
          ),
        ),
      ),
    );
  }
}
