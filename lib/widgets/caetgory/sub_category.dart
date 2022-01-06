// ignore_for_file: deprecated_member_use

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/services/firebase_services.dart';
import 'package:sizer/sizer.dart';

class Subcategory extends StatefulWidget {
  final String categoryname;
  // ignore: prefer_const_constructors_in_immutables
  Subcategory({Key? key, required this.categoryname}) : super(key: key);

  @override
  _SubcategoryState createState() => _SubcategoryState();
}

class _SubcategoryState extends State<Subcategory> {
  FirebaseServices _services = FirebaseServices();
  final TextEditingController _subcategorynamecontroller =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return Dialog(
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: SizedBox(
            height: height,
            width: width * 0.02.w,
            child: FutureBuilder<DocumentSnapshot>(
                future: _services.category.doc(widget.categoryname).get(),
                builder: (BuildContext context,
                    AsyncSnapshot<DocumentSnapshot> snapshot) {
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }

                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.data!.exists == 0) {
                    return const Center(child: Text('No Categories Added'));
                  }
                  Map<String, dynamic> data =
                      snapshot.data!.data() as Map<String, dynamic>;

                  return Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        child: Column(
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
                      ),
                      Container(
                        child: Expanded(
                            child: ListView.builder(
                          itemBuilder: (BuildContext context, int index) {
                            return ListTile(
                              contentPadding: EdgeInsets.zero,
                              trailing: IconButton(
                                  onPressed: () {},
                                  icon: const Icon(
                                    CupertinoIcons.delete_simple,
                                    color: dialog,
                                  )),
                              leading: CircleAvatar(
                                child: Text('${index + 1}'),
                              ),
                              title: Text(data['Sub-Category'][index]['name']),
                            );
                          },
                          itemCount: data['Sub-Category'] == null
                              ? 0
                              : data['Sub-Category'].length,
                        )),
                      ),
                      Container(
                          child: Column(children: [
                        const Divider(
                          thickness: 4,
                        ),
                        Container(
                          color: dialog,
                          height: height * 0.015.h,
                          width: width,
                          child: Column(children: [
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 5.0),
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
                                            focusedBorder:
                                                OutlineInputBorder()),
                                      ),
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    FlatButton(
                                        // hoverColor: dialog,
                                        height: height * 0.005.h,
                                        onPressed: () {
                                          if (_subcategorynamecontroller
                                              .text.isEmpty) {
                                            _services.showmydialog(
                                                title: "Add new Sub-Category",
                                                context: context,
                                                message:
                                                    " Need to Give Subcategoryname");
                                          }

                                          DocumentReference documentReference =
                                              _services.category
                                                  .doc(widget.categoryname);

                                          documentReference.update({
                                            "Sub-Category":
                                                FieldValue.arrayUnion([
                                              {
                                                "name":
                                                    _subcategorynamecontroller
                                                        .text
                                              }
                                            ])
                                          });
                                          setState(() {});
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
                          ]),
                        )
                      ]))
                    ],
                  );
                })),
      ),
    );
  }
}
