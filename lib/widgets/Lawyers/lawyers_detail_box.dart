import 'dart:html';
import 'dart:ui';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/services/firebase_services.dart';
import 'package:sizer/sizer.dart';

// ignore: must_be_immutable
class Lawyersdetails extends StatefulWidget {
  String uid;
  Lawyersdetails({Key? key, required this.uid}) : super(key: key);
  @override
  _LawyersdetailsState createState() => _LawyersdetailsState();
}

class _LawyersdetailsState extends State<Lawyersdetails> {
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return FutureBuilder(
      future: services.lawyer.doc(widget.uid).get(),
      // initialData: InitialData,
      builder:
          (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("something has Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
              child: CircularProgressIndicator(
            color: dialog,
          ));
        }
        return Dialog(
          child: Stack(
            children: [
              SizedBox(
                width: width * 0.3,
                height: height,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
                  child: ListView(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          SizedBox(
                              height: 200,
                              width: 200,
                              child: Image.network(
                                (snapshot.data!["images"]),
                              )),
                          // const SizedBox(
                          //   width: 20,
                          // ),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                snapshot.data!["name"],
                                style: titletext,
                              ),
                              Text(
                                snapshot.data!["category"],
                                style: contenttext,
                              ),
                            ],
                          )
                        ],
                      ),
                      divider,
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Expanded(
                                    child: Text(
                                  "Name",
                                  style: subtitletext,
                                )),
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(":"),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  snapshot.data!["name"],
                                  style: contenttext,
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "uid",
                                  style: subtitletext,
                                )),
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(":"),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  snapshot.data!["uid"],
                                  style: contenttext,
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Phone no",
                                  style: subtitletext,
                                )),
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(":"),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  snapshot.data!["mobile"],
                                  style: contenttext,
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Email",
                                  style: subtitletext,
                                )),
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(10),
                                    child: Text(":"),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  snapshot.data!["email"],
                                  style: contenttext,
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Description",
                                  style: subtitletext,
                                )),
                                Container(
                                  child: const Padding(
                                    padding: EdgeInsets.all(8),
                                    child: Text(":"),
                                  ),
                                ),
                                Expanded(
                                    child: Text(
                                  snapshot.data!["description"],
                                  textAlign: TextAlign.justify,
                                  style: GoogleFonts.poppins(
                                      color: black,
                                      fontSize: 2.sp,
                                      fontWeight: FontWeight.w400),
                                ))
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.all(5.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: Text(
                                  "Top Picked Status",
                                  style: subtitletext,
                                )),
                                const Padding(
                                  padding: EdgeInsets.all(8),
                                  child: Text(":"),
                                ),
                                Expanded(
                                    child: Container(
                                        color: white,
                                        child: snapshot.data!["toppicked"]
                                            ? Chip(
                                                backgroundColor: white,
                                                label: Row(
                                                  children: [
                                                    const Icon(
                                                      CupertinoIcons
                                                          .checkmark_seal_fill,
                                                      color: Colors.green,
                                                    ),
                                                    Text(
                                                      "Top picked",
                                                      style: contenttext,
                                                    )
                                                  ],
                                                ))
                                            : Chip(
                                                backgroundColor: white,
                                                label: Row(
                                                  children: const [
                                                    Icon(
                                                      CupertinoIcons
                                                          .minus_circled,
                                                      color: Colors.red,
                                                    ),
                                                    // Text(
                                                    //   "",
                                                    //   style: contenttext,
                                                    // )
                                                  ],
                                                ))))
                              ],
                            ),
                          ),
                          const Padding(
                            padding: EdgeInsets.symmetric(vertical: 8),
                            child: divider,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Positioned(
                  right: 20,
                  top: 20,
                  child: snapshot.data!["accountverified"]
                      ? Chip(
                          backgroundColor: white,
                          label: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.checkmark_seal_fill,
                                color: Colors.green,
                              ),
                              Text(
                                "Verified",
                                style: contenttext,
                              )
                            ],
                          ))
                      : Chip(
                          backgroundColor: white,
                          label: Row(
                            children: [
                              const Icon(
                                CupertinoIcons.minus_circled,
                                color: Colors.red,
                              ),
                              Text(
                                "unverified",
                                style: contenttext,
                              )
                            ],
                          )))
            ],
          ),
        );
      },
    );
  }
}
