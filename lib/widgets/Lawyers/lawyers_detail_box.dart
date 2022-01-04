import 'package:flutter/material.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/services/firebase_services.dart';

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
      builder: (BuildContext context, AsyncSnapshot snapshot) {
        if (snapshot.hasError) {
          return const Center(
            child: Text("something has Error"),
          );
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child:  CircularProgressIndicator(color: dialog,));
        }
        return Dialog(
          child:  SizedBox(
            width: width*0.3,
            height: height,child: Column(children: [Row(children: [
              SizedBox(height: 100,width: 100,child: Image.network(snapshot.data["images"],fit: BoxFit.contain,),)
            ],)],),
          ),
        );
      },
    );
  }
}
