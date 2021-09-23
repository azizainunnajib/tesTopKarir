import 'package:flutter/material.dart';
import 'package:flutter_apps/controller/indexbotnav.dart';
import 'package:flutter_apps/view/listLeague.view.dart';
import 'package:flutter_apps/view/search.view.dart';
import 'package:get/get.dart';

import 'view/listCountry.view.dart';

void main() {
  runApp(GetMaterialApp(
      theme: ThemeData(
          primarySwatch: Colors.blueGrey,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: MyHomePage(title: 'Football Apps')));
}

// class MyApp extends StatelessWidget {
//   // This widget is the root of your application.
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Flutter Demo',
//       theme: ThemeData(
//         primarySwatch: Colors.blueGrey,
//         // This makes the visual density adapt to the platform that you run
//         // the app on. For desktop platforms, the controls will be smaller and
//         // closer together (more dense) than on mobile platforms.
//         visualDensity: VisualDensity.adaptivePlatformDensity,
//       ),
//       home: MyHomePage(title: 'Football Apps'),
//     );
//   }
// }

class MyHomePage extends StatelessWidget {
  MyHomePage({this.title});
  List<Widget> mainPages = [ListCountry(), ListLeague(), Search()];
  final String title;
  @override
  Widget build(BuildContext context) {
    final IndexBottomNav c = Get.put(IndexBottomNav());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          title: Text(title),
        ),
        body: Obx(() => mainPages[c.index.value]),
        bottomNavigationBar: Obx(() => BottomNavigationBar(
              items: const <BottomNavigationBarItem>[
                BottomNavigationBarItem(
                  icon: Icon(Icons.home),
                  label: 'Home',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.settings),
                  label: 'Schedule',
                ),
                BottomNavigationBarItem(
                  icon: Icon(Icons.search),
                  label: 'Search',
                ),
              ],
              currentIndex: c.index.value,
              selectedItemColor: Colors.amber[800],
              onTap: (index) => c.changeIndex(index),
            )),
      ),
    );
  }
}
