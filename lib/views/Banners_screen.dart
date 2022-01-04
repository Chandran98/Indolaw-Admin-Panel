import 'dart:html';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:panel/routes/routes.dart';
import 'package:panel/widgets/Banners/Banners_upload_widget.dart';
import 'package:panel/widgets/Banners/banner_widget.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase/firebase.dart' as firebase;
import '../constant/constants.dart';
import '../services/firebase_services.dart';
import '../services/sidebar.dart';

class Bannersscreen extends StatefulWidget {
  static const String id = "Bannersscreen";
  @override
  _BannersscreenState createState() => _BannersscreenState();
}

class _BannersscreenState extends State<Bannersscreen> {
  SidebarWidget sidebarWidget = SidebarWidget();
  FirebaseServices service = FirebaseServices();
   bool _visible = false;
  bool _imageselected = true;
  var _fieldtexteditingcontroller = TextEditingController();
  String? _url;
  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        animationDuration: const Duration(microseconds: 500),
        backgroundColor: Color.fromARGB(255, 136, 85, 194).withOpacity(0.3));

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return AdminScaffold(
      sideBar: sidebarWidget.Sidebarmenu(context, bannersroute),
      appBar: AppBar(
        backgroundColor: dialog,
        title: const Text("Admin Dashboard"),
      ),
      body: SingleChildScrollView(
        child: Container(
          padding: const EdgeInsets.all(10),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Banners",
                style: header,
              ),
              Text(
                "Add or Delete Banner images",
                style: textfont,
              ),
              const Divider(
                thickness: 5,
              ),
              const Bannerwidget(),
              const Divider(
                thickness: 5,
              ),
              BannerUploadwidget()
           ],
          ),
        ),
      ),
    );
  }



  Future<void> _confirmdeletedialog({title, context, message, id}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: ListView(
                children: [Text(message)],
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      service.deletebannerimage(id);
                      Navigator.of(context).pop();
                    },
                    child: Text("Delete"))
              ],
            ));
  }

  Future<void> showmydialog({title, context, message}) {
    return showDialog(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: ListView(
                children: [Text(message)],
              ),
              actions: [
                // TextButton(onPressed: () {}, child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Ok"))
              ],
            ));
  }
}
