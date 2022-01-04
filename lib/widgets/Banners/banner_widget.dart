import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/services/firebase_services.dart';

import '../../main.dart';

class Bannerwidget extends StatefulWidget {
  const Bannerwidget({Key? key}) : super(key: key);

  @override
  _BannerwidgetState createState() => _BannerwidgetState();
}

class _BannerwidgetState extends State<Bannerwidget> {
  FirebaseServices services = FirebaseServices();
  ScrollController controller = ScrollController();
  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: services.bannerimages.snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Something went wrong');
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          return ScrollConfiguration(
            behavior: ScrollConfiguration.of(context).copyWith(
              dragDevices: {
                PointerDeviceKind.touch,
                PointerDeviceKind.mouse,
              },
            ),
            child: SizedBox(
              height: 350,
              child: ListView(
                shrinkWrap: true,
                controller: controller,
                scrollDirection: Axis.horizontal,
                children: snapshot.data!.docs
                    .map((DocumentSnapshot documentSnapshot) {
                  return Padding(
                    padding: const EdgeInsets.all(13.0),
                    child: Center(
                      child: Stack(
                        children: [
                          SizedBox(
                            height: 250,
                            width: 500,
                            child: Card(
                              elevation: 5,
                              child: ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Image(
                                    image: NetworkImage(
                                      documentSnapshot.get('images'),
                                    ),
                                    width: 400,
                                    fit: BoxFit.fill,
                                  )),
                            ),
                          ),
                          Positioned(
                              top: 10,
                              left: 10,
                              child: CircleAvatar(
                                child: IconButton(color: dialog,
                                  onPressed: () {
                                    services.confirmdeletedialog(
                                        title: "Delete Banner",
                                        message:
                                            "Are you sure you want to delete",
                                        id: documentSnapshot.id,
                                        context: context);
                                  },
                                  icon: const Icon(
                                    Icons.delete,
                                    color: dialog,
                                  ),
                                ),
                                backgroundColor: white,
                              ))
                        ],
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
          );
        });
  }
}
