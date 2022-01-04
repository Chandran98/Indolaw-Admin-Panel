
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:panel/services/firebase_services.dart';
// import 'package:panel/views/Mainscreen.dart';
// import 'package:sizer/sizer.dart';

// import '../constant/constants.dart';

// class Loginpage extends StatefulWidget {
//   Loginpage({Key? key}) : super(key: key);

//   Future<FirebaseApp> _future = Firebase.initializeApp();
//   @override
//   _LoginpageState createState() => _LoginpageState();
// }

// class _LoginpageState extends State<Loginpage> {
//   final formkey = GlobalKey<FormState>();

//   final Services _services = Services();

//   @override
//   Widget build(BuildContext context) {
//     late final height = MediaQuery.of(context).size.height;
//     late final width = MediaQuery.of(context).size.width;

//     return Scaffold(
//       // appBar: AppBar(),
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               colors: [Colors.purple.shade400, Colors.black],
//               stops: [0.2, 0.1],
//               begin: Alignment.topCenter),
//         ),
//         child: Center(
//           child: Container(
//             margin: const EdgeInsets.only(top: 20, left: 50, right: 50),
//             width: MediaQuery.of(context).size.width * 0.3,
//             height: MediaQuery.of(context).size.height * 0.4,
//             color: Colors.white,
//             child: Form(
//                 key: formkey,
//                 child: Column(
//                   children: [
//                     Padding(
//                       padding:
//                           const EdgeInsets.only(left: 50, right: 50, top: 50),
//                       child: Column(
//                         children: [
//                           // Container(
//                           //   height: 70,
//                           //   width: 300,
//                           //   decoration: const BoxDecoration(
//                           //       image: DecorationImage(
//                           //           image:
//                           //               AssetImage("assets/images/ILA_Logo1.png"))),
//                           // ),
//                           const SizedBox(
//                             height: 5,
//                           ),
//                           TextFormField(
//                             validator: (mail) {
//                               if (mail!.isEmpty) {
//                                 return "Required Id";
//                               } else {
//                                 return null;
//                               }
//                             },
//                             decoration: const InputDecoration(
//                                 prefixIcon: Icon(CupertinoIcons.mail),
//                                 hintText: "Email",
//                                 label: Text("Email"),
//                                 contentPadding: EdgeInsets.all(2),
//                                 border: OutlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Colors.purple))),
//                           ),
//                           const SizedBox(
//                             height: 10,
//                           ),
//                           TextFormField(
//                             validator: (password) {
//                               if (password!.isEmpty) {
//                                 return "Required password";
//                               }
//                               if (password.length < 4) {
//                                 return "Required minimum 4 letters";
//                               } else {
//                                 return null;
//                               }
//                             },
//                             decoration: const InputDecoration(
//                                 prefixIcon: Icon(CupertinoIcons.lock_shield),
//                                 hintText: "Password",
//                                 labelText: "Password",
//                                 contentPadding: EdgeInsets.all(2),
//                                 border: OutlineInputBorder(
//                                     borderSide:
//                                         BorderSide(color: Colors.purple))),
//                           ),
//                           SizedBox(
//                             height: height * 0.051,
//                           ),
//                           TextButton(
//                             onPressed: () {
//                               if (formkey.currentState!.validate()) {
//                                 // CircularProgressIndicator();
//                                 _services.getadmincredentails().then((value) {
//                                   value.docs.map((e) {
//                                     if (e.get('Username') == "Itachi") {
//                                       if (e.get("password") == "Sharingan") {
//                                         print("success");
//                                         // CircularProgressIndicator();
//                                         Navigator.pushReplacement(
//                                             context,
//                                             MaterialPageRoute(
//                                                 builder: (context) =>
//                                                     Mainscreen()));
//                                       } else {
//                                         _showdialogbox(
//                                             text: "Invalid Password",
//                                             message:
//                                                 "Please check your password");
//                                       }
//                                     } else {
//                                       _showdialogbox(
//                                           text: "Invalid Username",
//                                           message:
//                                               "Please check your username");
//                                     }
//                                   });
//                                 });
//                               }
//                             },
//                             child: Container(
//                                 decoration: BoxDecoration(
//                                     // borderRadius: BorderRadius.circular(35),
//                                     color: white,
//                                     border: Border.all(color: dialog)),
//                                 height: height * 0.045,
//                                 width: width * 0.1,
//                                 // padding: const EdgeInsets.symmetric(
//                                 //   vertical: 15.0,
//                                 //   horizontal: 15.0,
//                                 // ),
//                                 child: Center(
//                                   child: Text(
//                                     "Login",
//                                     style: GoogleFonts.poppins(
//                                         fontSize: 4.sp,
//                                         color: black,
//                                         fontWeight: FontWeight.w400),
//                                     textAlign: TextAlign.center,
//                                   ),
//                                 )),
//                           )
//                         ],
//                       ),
//                     )
//                   ],
//                 )),
//           ),
//         ),
//       ),
//     );
//   }

//   Future<void> _showdialogbox({text, message}) async {
//     return await showDialog(
//         context: context,
//         builder: (
//           context,
//         ) {
//           return AlertDialog(
//             title: text,
//             content: SingleChildScrollView(
//               child: ListBody(
//                 children: [Text(message), const Text("Please Try again")],
//               ),
//             ),
//             actions: [
//               TextButton(
//                   onPressed: () {
//                     Navigator.of(context).pop();
//                   },
//                   child: const Text("Ok"))
//             ],
//           );
//         });
//   }
// }
