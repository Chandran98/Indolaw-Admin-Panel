import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:panel/routes/routes.dart';
import 'package:panel/views/Lawyers_screen.dart';
import 'package:panel/views/Mainscreen.dart';

import '../constant/constants.dart';
import '../views/Banners_screen.dart';
import '../views/Notification_screen.dart';
import '../views/Settings_screen.dart';
import '../views/cases_order.dart';

class SidebarWidget {
  Sidebarmenu(context, slectedroute) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return SideBar(activeBackgroundColor: dialog,
      activeIconColor: white,
      backgroundColor: Colors.white,
      iconColor: Colors.grey,textStyle: 
          GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w400,color: Colors.grey),
      activeTextStyle:
          GoogleFonts.poppins(fontSize: 15, fontWeight: FontWeight.w500,color: white),
      header: Container(
        color: dialog,
        child: Center(
            child: Text(
          "Menu",
          style: dfont,
        )),
        height: height * 0.05,
      ),
      footer: Container(
        height: height * 0.12,
        color: dialog,
      ),
      items: const [
        MenuItem(
          title: 'Dashboard',
          route: mainscreenroute,
          icon: Icons.dashboard,
        ),
        MenuItem(
          title: 'Banners',
          route: bannersroute,
          icon: CupertinoIcons.photo_fill,
        ),
        MenuItem(
          title: 'Categories',
          route: casesorderroute,
          icon: Icons.category,
        ),
          MenuItem(
          title: 'Lawyers',
          route: lawyerscreenroute,
          icon: CupertinoIcons.profile_circled,
        ),
        MenuItem(
          title: 'Send Notifications',
          route: notificationroute,
          icon: Icons.notifications_active,
        ),
        MenuItem(
          title: 'Settings',
          route: settingsroute,
          icon: CupertinoIcons.settings,
        ), //  MenuItem(
        //   title: 'Exit',
        //   route: Settingsscreen.id,
        //   icon: CupertinoIcons.settings,
        // ),

        // MenuItem(
        //   title: 'Top Level',
        //   icon: Icons.file_copy,
        //   children: [
        //     MenuItem(
        //       title: 'Second Level Item 1',
        //       route: '/secondLevelItem1',
        //     ),
        //     MenuItem(
        //       title: 'Second Level Item 2',
        //       route: '/secondLevelItem2',
        //     ),
        //     MenuItem(
        //       title: 'Third Level',
        //       children: [
        //         MenuItem(
        //           title: 'Third Level Item 1',
        //           route: '/thirdLevelItem1',
        //         ),
        //         MenuItem(
        //           title: 'Third Level Item 2',
        //           route: '/thirdLevelItem2',
        //           icon: Icons.image,
        //         ),
        //       ],
        //     ),
        //   ],
        // ),
      ],
      selectedRoute: slectedroute,
      onSelected: (item) {
        Navigator.of(context).pushNamed(item.route!);
      },
    );
  }
}
