import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

class FirebaseServices {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  CollectionReference bannerimages =
      FirebaseFirestore.instance.collection("Banners");
  CollectionReference lawyer = FirebaseFirestore.instance.collection("Lawyers");
  CollectionReference category =
      FirebaseFirestore.instance.collection("Category");

  FirebaseStorage storage = FirebaseStorage.instance;
  Future<QuerySnapshot> getadmincredentails(username) {
    var result = FirebaseFirestore.instance.collection('Admin').get();
    return result;
  }

////banner ////
  Future<String> uploadimagestoDB(url) async {
    String downloadurl = await storage.ref(url).getDownloadURL();
    if (downloadurl != null) {
      firestore.collection("Banners").add({"images": downloadurl});
    }
    return downloadurl;
  }

  Future<void> deletebannerimage(id) async {
    firestore.collection("Banners").doc(id).delete();
  }

  //// lawyer ////

  lawyerstatus({id, status}) async {
    lawyer.doc(id).update({"accountverified": status ? false : true});
  }

  toplawyer({id, status}) async {
    lawyer.doc(id).update({"toppicked": status ? false : true});
  }

//// category ////

  Future<String> uploadcataegory(url, categoryname) async {
    String downloadurl = await storage.ref(url).getDownloadURL();
    if (downloadurl != null) {
      category
          .doc(categoryname)
          .set({"images": downloadurl, "name": categoryname});
    }
    return downloadurl;
  }

  ///content///

  Future<void> confirmdeletedialog({title, context, message, id}) {
    return showDialog<void>(
        context: context,
        barrierDismissible: false,
        builder: (_) => AlertDialog(
              title: Text(title),
              content: SingleChildScrollView(
                child: ListBody(
                  children: [Text(message)],
                ),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      deletebannerimage(id);
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
              content: SingleChildScrollView(
                child: ListBody(
                  children: [Text(message)],
                ),
              ),
              actions: [
                // TextButton(onPressed: () {}, child: Text("Cancel")),
                TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text("Ok"))
              ],
            ));
  }
}













  // Future<void> showMyDialog({title, message, context}) async {
  //   return showDialog<void>(
  //     context: context,
  //     barrierDismissible: false, // user must tap button!
  //     builder: (BuildContext context) {
  //       return AlertDialog(
  //         title: Text(title),
  //         content: SingleChildScrollView(
  //           child: ListBody(
  //             children: <Widget>[
  //               Text(message),
  //             ],
  //           ),
  //         ),
  //         actions: <Widget>[
  //           TextButton(
  //             child: const Text('OK'),
  //             onPressed: () {
  //               Navigator.of(context).pop();
  //             },
  //           ),
  //         ],
  //       );
  //     },
  //   );
  // }