import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_colorpicker/flutter_colorpicker.dart';
import 'package:tasks/controllers/arrayController.dart';
import 'package:tasks/services/Notification.service.dart';
import 'package:tasks/services/database.service.dart';
import 'package:tasks/utils/routes.dart';
import 'package:tasks/utils/global.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../controllers/authController.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({Key? key}) : super(key: key);

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  final AuthController authController = Get.find();
  final ArrayController arrayController = Get.put(ArrayController());
  final String uid = Get.find<AuthController>().user!.uid;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          centerTitle: false,
          title: Text("Tasks",
              style: GoogleFonts.notoSans(
                fontSize: 30,
                color: primaryColor,
                fontWeight: FontWeight.bold,
              )),
          actions: [
            IconButton(
                onPressed: () {
                  showModalBottomSheet<void>(
                    backgroundColor: tertiaryColor,
                    context: context,
                    builder: (BuildContext context) {
                      return Container(
                        padding: const EdgeInsets.only(top: 15.0),
                        height: 310,
                        child: ListView(children: [
                          const SizedBox(height: 10.0),
                          Center(
                            child: Icon(
                              Icons.account_circle,
                              size: 40.0,
                              color: primaryColor,
                            ),
                          ),
                          const SizedBox(height: 15.0),
                          Center(
                              child: Text(
                            authController.user!.email ?? '',
                            style: const TextStyle(
                                fontSize: 20.0, color: Colors.white),
                          )),
                          const SizedBox(height: 15.0),
                          dividerStyle,
                          ListTile(
                            title: Text(
                              "Change theme",
                              style: optionsTextStyle,
                            ),
                            leading: Icon(
                              Icons.color_lens_sharp,
                              color: primaryColor,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              showDialog<String>(
                                barrierDismissible: true,
                                context: context,
                                builder: (BuildContext context) => AlertDialog(
                                  backgroundColor:
                                      const Color.fromARGB(255, 37, 37, 37),
                                  title: const Text('Pick a color',
                                      style: TextStyle(color: Colors.white)),
                                  actions: [
                                    ColorPicker(
                                        showLabel: false,
                                        pickerColor: primaryColor,
                                        onColorChanged: (color) {
                                          setState(() {
                                            primaryColor = color;
                                          });
                                        }),
                                    TextButton(
                                      onPressed: () => Navigator.pop(
                                          context, 'Select Color'),
                                      child: const Text('Select Color',
                                          style:
                                              TextStyle(color: Colors.white)),
                                    )
                                  ],
                                ),
                              );
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Sign out",
                              style: optionsTextStyle,
                            ),
                            leading: Icon(
                              Icons.logout,
                              color: primaryColor,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              authController.signOut(context);
                            },
                          ),
                          ListTile(
                            title: Text(
                              "Delete account",
                              style: optionsTextStyle,
                            ),
                            leading: Icon(
                              Icons.delete,
                              color: primaryColor,
                            ),
                            onTap: () {
                              Navigator.pop(context);
                              authController.deleteAccount(context);
                            },
                          ),
                        ]),
                      );
                    },
                  );
                },
                icon: menuIcon)
          ],
        ),
        body: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Container(
            width: double.infinity,
            padding:
                const EdgeInsets.symmetric(horizontal: 15.0, vertical: 15.0),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.circular(14.0)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "0",
                                style: GoogleFonts.notoSans(
                                    fontSize: 40.0, color: primaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Today",
                                style: GoogleFonts.notoSans(
                                    fontSize: 25.0, color: Colors.white),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.circular(14.0)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "0",
                                style: GoogleFonts.notoSans(
                                    fontSize: 40.0, color: primaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Scheduled",
                                style: GoogleFonts.notoSans(
                                    fontSize: 25.0, color: Colors.white),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20.0,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.circular(14.0)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "0",
                                style: GoogleFonts.notoSans(
                                    fontSize: 40.0, color: primaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "All",
                                style: GoogleFonts.notoSans(
                                    fontSize: 25.0, color: Colors.white),
                              ),
                            ),
                          ]),
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width * 0.45,
                      height: MediaQuery.of(context).size.height * 0.15,
                      decoration: BoxDecoration(
                          color: tertiaryColor,
                          borderRadius: BorderRadius.circular(14.0)),
                      child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "0",
                                style: GoogleFonts.notoSans(
                                    fontSize: 40.0, color: primaryColor),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 20.0),
                              child: Text(
                                "Completed",
                                style: GoogleFonts.notoSans(
                                    fontSize: 25.0, color: Colors.white),
                              ),
                            ),
                          ]),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 30.0,
                ),
                Align(
                    alignment: Alignment.centerLeft,
                    child: Text("Lists",
                        style: GoogleFonts.notoSans(
                          fontSize: 30,
                          color: primaryColor,
                          fontWeight: FontWeight.bold,
                        ))),
                const SizedBox(
                  height: 30.0,
                ),
                Column(
                  children: [
                    Container(
                        height: MediaQuery.of(context).size.height * 0.37,
                        child: GetX<ArrayController>(
                            init: Get.put<ArrayController>(ArrayController()),
                            builder: (ArrayController arrayController) {
                              return (arrayController.arrays.isEmpty)
                                  ? Container(
                                      height:
                                          MediaQuery.of(context).size.height *
                                              0.37,
                                      child: Center(
                                          child: Text("Add new lists",
                                              style: buttonTextStyleWhite)),
                                    )
                                  : ListView.separated(
                                      shrinkWrap: true,
                                      physics: const BouncingScrollPhysics(),
                                      itemBuilder: (context, index) =>
                                          GestureDetector(
                                            onLongPress: () {
                                              Navigator.of(context).push(Routes
                                                  .routeToArrayScreenIndex(
                                                      index,
                                                      arrayController
                                                          .arrays[index].id));
                                            },
                                            onTap: () {
                                              Navigator.of(context).push(
                                                  Routes.routeToHomeScreen(
                                                      index));
                                            },
                                            child: Dismissible(
                                              key: UniqueKey(),
                                              direction:
                                                  DismissDirection.startToEnd,
                                              onDismissed: (_) {
                                                HapticFeedback.heavyImpact();
                                                Database().deleteArray(
                                                    uid,
                                                    arrayController
                                                            .arrays[index].id ??
                                                        '');
                                                for (var i = 0;
                                                    i <
                                                        arrayController
                                                            .arrays[index]
                                                            .todos!
                                                            .length;
                                                    i++) {
                                                  NotificationService()
                                                      .flutterLocalNotificationsPlugin
                                                      .cancel(arrayController
                                                          .arrays[index]
                                                          .todos![i]
                                                          .id!);
                                                }
                                              },
                                              child: Container(
                                                width: double.infinity,
                                                height: MediaQuery.of(context)
                                                        .size
                                                        .height *
                                                    0.07,
                                                decoration: BoxDecoration(
                                                    color: tertiaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            14.0)),
                                                child: Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          right: 25.0),
                                                  child: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .spaceBetween,
                                                    children: [
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20.0),
                                                        child: Text(
                                                          arrayController
                                                                  .arrays[index]
                                                                  .title ??
                                                              '',
                                                          style: GoogleFonts
                                                              .notoSans(
                                                                  color: Colors
                                                                      .white,
                                                                  fontSize:
                                                                      25.0),
                                                        ),
                                                      ),
                                                      Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 20.0),
                                                        child: Text(
                                                          '${arrayController.arrays[index].todos!.length}',
                                                          style: GoogleFonts
                                                              .notoSans(
                                                                  color:
                                                                      primaryColor,
                                                                  fontSize:
                                                                      27.0),
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                      separatorBuilder: (_, __) =>
                                          const SizedBox(
                                            height: 15.0,
                                          ),
                                      itemCount: arrayController.arrays.length);
                            })),
                  ],
                )
              ],
            ),
          ),
        ),
        floatingActionButton: GestureDetector(
            onTap: () {
              Navigator.of(context).push(Routes.routeToArrayScreen());
            },
            child: Container(
              decoration: BoxDecoration(
                  color: tertiaryColor,
                  borderRadius: BorderRadius.circular(14.0)),
              width: 140.0,
              height: 55.0,
              child: Center(
                child: Text('Add list',
                    style: TextStyle(color: primaryColor, fontSize: 23.0)),
              ),
            )));
  }
}
