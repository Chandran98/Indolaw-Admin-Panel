import 'package:chips_choice/chips_choice.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:panel/constant/constants.dart';
import 'package:panel/services/firebase_services.dart';
import 'package:panel/widgets/Lawyers/lawyers_detail_box.dart';
import 'package:sizer/sizer.dart';

class Lawyertable extends StatefulWidget {
  const Lawyertable({Key? key}) : super(key: key);

  @override
  State<Lawyertable> createState() => _LawyertableState();
}

class _LawyertableState extends State<Lawyertable> {
  int tag = 0;
  List<String> options = [
    "All Lawyers",
    "Active Lawyers",
    "Inactive Lawyers",
    "Top Picked",
    "Top Rated"
  ];
  bool? toppicked;
  bool? active;
  filter(val) {
    if (val == 1) {
      setState(() {
        active = true;
      });
    }
    if (val == 2) {
      setState(() {
        active = false;
      });
    }
    if (val == 3) {
      setState(() {
        toppicked == true;
      });
    }

    if (val == 0) {
      setState(() {
        // toppicked == null;
        // active == null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    FirebaseServices services = FirebaseServices();
    return Column(
      children: [
        ChipsChoice<int>.single(
          choiceActiveStyle: const C2ChoiceStyle(
            brightness: Brightness.dark,
          ),
          value: tag,
          onChanged: (val) {
            setState(() {
              tag = val;
            });              filter(val);

          },
          choiceItems: C2Choice.listFrom<int, String>(
            activeStyle: (i, v) {
              return C2ChoiceStyle(brightness: Brightness.dark, color: dialog);
            },
            source: options,
            value: (i, v) => i,
            label: (i, v) => v,
          ),
        ),
        StreamBuilder(
          stream: services.lawyer
              .where("toppicked", isEqualTo: toppicked)
              .where("accountverified", isEqualTo: active)
              .snapshots(),
          // initialData: initialData,
          builder: (BuildContext context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something has Error"),
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            }
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: DataTable(
                  showBottomBorder: true,
                  dataRowHeight: MediaQuery.of(context).size.height * 0.008.h,
                  headingRowColor:
                      MaterialStateProperty.all(Colors.grey.shade300),
                  // ignore: prefer_const_literals_to_create_immutables
                  columns: [
                    const DataColumn(label: Text("Active / Inactive")),
                    const DataColumn(label: Text("Top picked")),
                    const DataColumn(label: Text("Lawyer name")),
                    const DataColumn(label: Text("Category")),
                    const DataColumn(label: Text("Rating")),
                    const DataColumn(label: Text("Mobile")),
                    const DataColumn(label: Text("Email")),
                    const DataColumn(label: Text("View Details")),
                  ],
                  rows: _lawyerdetailsrow(snapshot.data, services)),
            );
          },
        ),
      ],
    );
  }

  List<DataRow> _lawyerdetailsrow(
      QuerySnapshot snapshot, FirebaseServices services) {
    List<DataRow> lawyerlist = snapshot.docs.map((DocumentSnapshot document) {
      return DataRow(cells: [
        DataCell(
          IconButton(
            onPressed: () {
              services.lawyerstatus(
                  id: document.get("uid"),
                  status: document.get("accountverified"));
            },
            icon: document.get("accountverified")
                ? const Icon(
                    CupertinoIcons.checkmark_seal,
                    color: Colors.green,
                  )
                : const Icon(
                    CupertinoIcons.minus_circle,
                    color: Colors.red,
                  ),
          ),
        ),
        DataCell(
          IconButton(
            onPressed: () {
              services.toplawyer(
                  id: document.get("uid"), status: document.get("toppicked"));
            },
            icon: document.get("toppicked")
                ? const Icon(
                    CupertinoIcons.star_fill,
                    color: Colors.green,
                  )
                : const Icon(
                    CupertinoIcons.star_slash_fill,
                    color: Colors.red,
                  ),
          ),
        ),
        DataCell(Text(document.get("name"))),
        DataCell(Text(document.get("category"))),
        DataCell(Row(
          children: const [Icon(Icons.star), Text("4")],
        )),
        DataCell(Text(document.get("mobile"))),
        DataCell(Text(document.get("email"))),
        DataCell(IconButton(
            onPressed: () {
              showDialog(
                  context: context,
                  builder: (context) {
                    return Lawyersdetails(
                      uid: "uid",
                    );
                  });
            },
            icon: const Icon(
              CupertinoIcons.info_circle,
              color: dialog,
            ))),
      ]);
    }).toList();

    return lawyerlist;
  }
}
