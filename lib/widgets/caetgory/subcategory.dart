// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/services/firebase_services.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Subcategorycard extends StatefulWidget {
  String categoryname;
  Subcategorycard({Key? key, required this.categoryname}) : super(key: key);

  @override
  _SubcategorycardState createState() => _SubcategorycardState();
}

class _SubcategorycardState extends State<Subcategorycard> {
  FirebaseServices services = FirebaseServices();
  final TextEditingController _subcategorynamecontroller =
      TextEditingController();
  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
        child: SizedBox(
      height: height,
      width: width * 0.02.w,
      child: Padding(
        padding: const EdgeInsets.all(10),
        child: FutureBuilder<DocumentSnapshot>(
          future: services.category.doc(widget.categoryname).get(),
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (snapshot.hasError) {
              return const Text("Something has gone Wrong");
            }
            // if (snapshot.connectionState == ConnectionState.waiting) {

            // }
            if (snapshot.connectionState == ConnectionState.done) {
              // if (!snapshot.data) {
              //   return const Text("No category added");
              // }
              Map<String, dynamic> data =
                  snapshot.data!.data() as Map<String, dynamic>;
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      Row(
                        children: [
                          Expanded(
                            flex: 1,
                            child: Text(
                              "Main Category  :",
                              style: subtitletext,
                            ),
                          ),
                          Expanded(
                            flex: 3,
                            child: Text(
                              widget.categoryname,
                              style: contenttext,
                            ),
                          )
                        ],
                      ),
                      const Padding(
                        padding: EdgeInsets.symmetric(vertical: 8.0),
                        child: divider,
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.builder(
                      // itemCount: data["sub category"] == null
                      //     ? 0
                      //     : data["sub category"].length,
                      itemBuilder: (BuildContext context, int index) {
                        return ListTile(
                          leading: CircleAvatar(
                            child: Text("{$index+1}"),
                          ),
                          title: Text(data["sub category"][index]["name"]),
                        );
                      },
                    ),
                  ),
                  Container(
                    color: dialog,
                    height: height * 0.015.h,
                    width: width,
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 5.0),
                          child: Text(
                            "Add new Subcategory",
                            style: dfont,
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            Row(
                              children: [
                                SizedBox(
                                  width: width * 0.01.w,
                                  height: height * 0.005.h,
                                  child: TextField(
                                    controller: _subcategorynamecontroller,
                                    decoration: const InputDecoration(
                                        hintText: "Subcategories",
                                        filled: true,
                                        fillColor: white,
                                        border: OutlineInputBorder(),
                                        contentPadding: EdgeInsets.all(8),
                                        focusedBorder: OutlineInputBorder()),
                                  ),
                                ),
                                const SizedBox(
                                  width: 30,
                                ),
                                FlatButton(
                                    hoverColor: dialog,
                                    height: height * 0.005.h,
                                    onPressed: () {
                                      if (_subcategorynamecontroller
                                          .text.isEmpty) {
                                        services.showmydialog(
                                            title: "Add new Sub-Category",
                                            context: context,
                                            message:
                                                " Need to Give Subcategoryname");
                                      }

                                      DocumentReference documentReference =
                                          services.category
                                              .doc(widget.categoryname);

                                      documentReference.update({
                                        "Sub- Category": FieldValue.arrayUnion([
                                          {
                                            "name":
                                                _subcategorynamecontroller.text
                                          }
                                        ])
                                      });
                                      setState(() {
                                        
                                      });
                                      _subcategorynamecontroller.clear();
                                    },
                                    color: white,
                                    child: Text(
                                      "save",
                                      style: textfont,
                                    ))
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                ],
              );
            }
            return const Center(
              child: CircularProgressIndicator(),
            );
          },
        ),
      ),
    ));
  }
}
