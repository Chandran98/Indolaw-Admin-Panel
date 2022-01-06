import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:panel/widgets/caetgory/sub_category.dart';
import 'package:sizer/sizer.dart';

class Categorycard extends StatelessWidget {
  DocumentSnapshot document;

  Categorycard({Key? key, required this.document}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    final width = MediaQuery.of(context).size.width;
    return InkWell(
      onTap: () {
        showDialog(
            context: context,
            builder: (context) {
              return  Subcategory(categoryname: document["name"],);
            });
      },
      child: SizedBox(
        height: height * 0.03.h,
        width: width * 0.01.w,
        child: Card(color: Colors.grey.shade50,
          child: Padding(
              padding: const EdgeInsets.all(10),
              child: Center(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 70,
                      width: double.infinity,
                      child: Image.network(document["images"]),
                    ),
                    Flexible(child: Text(document["name"]))
                  ],
                ),
              )),
          elevation: 4,
        ),
      ),
    );
  }
}
