import 'dart:html';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panel/services/firebase_services.dart';
import 'package:panel/widgets/caetgory/category_card.dart';

class Categorylist extends StatefulWidget {
   Categorylist({Key? key,}) : super(key: key);
  

  @override
  State<Categorylist> createState() => _CategorylistState();
}

class _CategorylistState extends State<Categorylist> {
  FirebaseServices services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;

    return SizedBox(
      width: width,
      child: StreamBuilder(
        stream: services.category.snapshots(),
        // initialData: initialData,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text("Something has gone Wrong");
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const CircularProgressIndicator();
          }
          return Wrap(
              direction: Axis.horizontal,
              children:
                  snapshot.data!.docs.map((DocumentSnapshot documentSnapshot) {
                return Categorycard(document: documentSnapshot,);
              }).toList());
        },
      ),
    );
  }
}
