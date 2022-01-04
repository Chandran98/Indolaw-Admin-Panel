import 'dart:html';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/services/firebase_services.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase/firebase.dart' as firebase;

class BannerUploadwidget extends StatefulWidget {
  BannerUploadwidget({Key? key}) : super(key: key);

  @override
  _BannerUploadwidgetState createState() => _BannerUploadwidgetState();
}

class _BannerUploadwidgetState extends State<BannerUploadwidget> {
  FirebaseServices service = FirebaseServices();
  String? _url;

  bool _visible = false;
  bool _imageselected = true;
  var _fieldtexteditingcontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        animationDuration: const Duration(microseconds: 500),
        backgroundColor: Color.fromARGB(255, 136, 85, 194).withOpacity(0.3));

    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Container(
      color: Color.fromARGB(77, 235, 223, 223),
      height: height * 0.01.h,
      width: width * 1.w,
      child: Row(
        children: [
          Visibility(
            visible: _visible,
            child: Row(
              children: [
                AbsorbPointer(
                  absorbing: true,
                  child: SizedBox(
                    child: TextField(
                      controller: _fieldtexteditingcontroller,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          fillColor: white,
                          filled: true,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(20),
                          hintText: "Upload images"),
                    ),
                    width: width * 0.007.w,
                  ),
                ),
                TextButton(
                    onPressed: () {
                      uploadstorage();
                    },
                    child: Container(
                        color: dialog,
                        height: height * 0.005.h,
                        width: width * 0.005.w,
                        child: Center(
                          child: Text(
                            "Upload images",
                            style: dfont,
                            textAlign: TextAlign.center,
                          ),
                        ))),
                AbsorbPointer(
                  absorbing: _imageselected,
                  child: TextButton(
                      onPressed: () {
                        service.uploadimagestoDB(_url).then((downloadurl) {
                          if (downloadurl != null) {
                            service.showmydialog(
                                title: "New Banner Image",
                                context: context,
                                message: "Image saved successfully");
                          } else {
                            return const CircularProgressIndicator();
                          }
                        });
                      },
                      child: Container(
                          color: _imageselected ? Colors.grey.shade500 : dialog,
                          height: height * 0.005.h,
                          width: width * 0.005.w,
                          child: Center(
                            child: Text(
                              "Save images",
                              style: dfont,
                            ),
                          ))),
                ),
              ],
            ),
          ),
          Visibility(
            visible: _visible ? false : true,
            child: TextButton(
                onPressed: () {
                  setState(() {
                    _visible = true;
                  });
                },
                child: Container(
                    color: dialog,
                    height: height * 0.005.h,
                    width: width * 0.005.w,
                    child: Center(
                      child: Text(
                        "Add New Banner",
                        style: dfont,
                      ),
                    ))),
          )
        ],
      ),
    );
  }

  void uploadimage({required Function(File file) onselected}) {
    InputElement uploadinput = FileUploadInputElement() as InputElement
      ..accept = "image/*";
    uploadinput.click();
    uploadinput.onChange.listen((event) {
      final file = uploadinput.files!.first;
      final reader = FileReader();
      reader.readAsDataUrl(file);
      reader.onLoadEnd.listen((event) {
        onselected(file);
      });
    });
  }

  void uploadstorage() {
    final datetime = DateTime.now();
    final path = "Bannerimage/$datetime";
    uploadimage(onselected: (file) {
      if (file != null) {
        setState(() {
          _fieldtexteditingcontroller.text = file.name;

          _imageselected = false;
          _url = path;
        });
      } else {
        return const CircularProgressIndicator();
      }

      firebase
          .storage()
          .refFromURL("gs://indolawassociates-571ca.appspot.com")
          .child(path)
          .put(file);
    });
  }
}
