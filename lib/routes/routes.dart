
import 'package:panel/views/Banners_screen.dart';
import 'package:panel/views/Lawyers_screen.dart';
import 'package:panel/views/Mainscreen.dart';
import 'package:panel/views/Notification_screen.dart';
import 'package:panel/views/Settings_screen.dart';
import 'package:panel/views/categories.dart';

const String mainscreenroute = "/mainscreen";
const String settingsroute = "/settings";
// const String casesorderroute = "/casesorder";
const String categoryroute = "/category";
const String bannersroute = "/banners";
const String notificationroute = "/notification";
const String lawyerscreenroute = "/lawyerscreen";

final routes = {
  mainscreenroute: (context) => Mainscreen(),
  settingsroute: (context) => Settingsscreen(),
  bannersroute: (context) => Bannersscreen(),
  categoryroute: (context) => Category(),
  notificationroute: (context) => Notificationscreen(),
  lawyerscreenroute:(context)=>Lawyerscreen(),
};

            // Mainscreen.id: (context) => Mainscreen(),
            // Settingsscreen.id: (context) => Settingsscreen(),
            // Bannersscreen.id: (context) => Bannersscreen(),
            // Caseorder.id: (context) => Caseorder(),
            // Notificationscreen.id: (context) => Notificationscreen(),
            // Lawyerscreen.id:(context)=>Lawyerscreen(),