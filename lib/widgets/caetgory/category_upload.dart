import 'dart:html';
import 'package:ars_progress_dialog/ars_progress_dialog.dart';
import 'package:flutter/material.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/services/firebase_services.dart';
import 'package:sizer/sizer.dart';
import 'package:firebase/firebase.dart' as firebase;

class Uploadcategory extends StatefulWidget {
  const Uploadcategory({Key? key}) : super(key: key);

  @override
  State<Uploadcategory> createState() => _UploadcategoryState();
}

class _UploadcategoryState extends State<Uploadcategory> {
  FirebaseServices service = FirebaseServices();
  String? _url;

  bool _visible = false;
  bool _imageselected = true;
  var _fieldtexteditingcontroller = TextEditingController();
  var _categorynamecontroller = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ArsProgressDialog progressDialog = ArsProgressDialog(context,
        blur: 2,
        animationDuration: const Duration(microseconds: 500),
        backgroundColor:
            const Color.fromARGB(255, 136, 85, 194).withOpacity(0.3));
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
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: SizedBox(
                    width: width * 0.007.w,
                    child: TextField(
                      controller: _categorynamecontroller,
                      decoration: const InputDecoration(
                          focusedBorder: OutlineInputBorder(
                              borderSide:
                                  BorderSide(color: Colors.black, width: 1)),
                          fillColor: white,
                          filled: true,
                          border: OutlineInputBorder(),
                          contentPadding: EdgeInsets.all(20),
                          hintText: "Enter Category name"),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AbsorbPointer(
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
                            hintText: "Upload Category"),
                      ),
                      width: width * 0.007.w,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextButton(
                      onPressed: () {
                        uploadstorage();
                      },
                      child: Container(
                          color: dialog,
                          height: height * 0.005.h,
                          width: width * 0.005.w,
                          child: Center(
                            child: Text(
                              "Upload Category",
                              style: dfont,
                              textAlign: TextAlign.center,
                            ),
                          ))),
                ),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: AbsorbPointer(
                    absorbing: _imageselected,
                    child: TextButton(
                        onPressed: () {
                          if (_categorynamecontroller.text.isEmpty) {
                            service.showmydialog(
                                context: context,
                                title: "Add New Category",
                                message: "Enter Category name");
                          } else {
                            progressDialog.show();
                            service
                                .uploadcataegory(
                                    _url, _categorynamecontroller.text)
                                .then((value) {
                              if (value != null) {
                                progressDialog.dismiss();
                                service.showmydialog(
                                    title: "New category",
                                    message: "New category and successfully",
                                    context: context);
                                _categorynamecontroller.clear();
                                _fieldtexteditingcontroller.clear();
                              } else {
                                return CircularProgressIndicator();
                              }
                            });
                          }
                          // service.uploadimagestoDB(_url).then(
                          //   (downloadurl) {
                          //     if (downloadurl != null) {
                          //       service.showmydialog(
                          //           title: "New Category ",
                          //           context: context,
                          //           message: "New category saved successfully");
                          //     } else {
                          //       return const CircularProgressIndicator();
                          //     }
                          //   },
                          // );
                        },
                        child: Container(
                            color:
                                _imageselected ? Colors.grey.shade500 : dialog,
                            height: height * 0.005.h,
                            width: width * 0.005.w,
                            child: Center(
                              child: Text(
                                "Save category",
                                style: dfont,
                              ),
                            ))),
                  ),
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
                    width: width * 0.008.w,
                    child: Center(
                      child: Text(
                        "Add New category",
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
    final path = "CategoryImage/$datetime";
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
