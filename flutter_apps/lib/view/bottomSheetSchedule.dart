import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/controller/allLeague.controller.dart';
import 'package:flutter_apps/controller/schedule.controler.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomSheetSchedule extends StatelessWidget {
  const BottomSheetSchedule({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScheduleController scheduleController = Get.find();
    scheduleController.getAllSeason();
    AllLeague allLeague = Get.find();

    return Obx(() => Container(
          padding: EdgeInsets.all(8),
          child: Column(
            children: [
              DropdownSearch<String>(
                  mode: Mode.MENU,
                  showSearchBox: true,
                  showSelectedItem: true,
                  selectedItem: allLeague.items.value
                      .firstWhere((e) =>
                          e['idLeague'].toString() ==
                          scheduleController.idLiga.value)["strLeague"]
                      .toString(),
                  items: allLeague.items.value
                      .map((e) => e['strLeague'].toString())
                      .toList(),
                  label: "Find Season",
                  hint: "Season",
                  // popupItemDisabled: (String s) => s.startsWith('I'),
                  onChanged: (x) {
                    print(x);
                    var i = allLeague.items.value
                        .firstWhere((e) => e['strLeague'].toString() == x);
                    scheduleController.idLiga.value = i["idLeague"];
                    scheduleController.getAllSeason();
                  }),
              SizedBox(
                height: 8,
              ),
              CupertinoPicker(
                  backgroundColor: Colors.black12,
                  itemExtent: 50,
                  onSelectedItemChanged: (value) {
                    scheduleController.season.value =
                        scheduleController.allSeason.reversed.toList()[value];
                  },
                  children: scheduleController.allSeason.reversed
                      .map((e) => Text(e,
                          style: GoogleFonts.abrilFatface(
                              fontSize: 20, fontWeight: FontWeight.normal)))
                      .toList()),
              SizedBox(
                height: 8,
              ),
              ElevatedButton(
                  onPressed: () {
                    scheduleController.liga.value = allLeague.items.firstWhere(
                        (e) =>
                            e["idLeague"].toString() ==
                            scheduleController.idLiga.value)['strLeague'];
                    scheduleController.getAllSchedule();
                    Get.back();
                  },
                  child: Text('Submit'))
            ],
          ),
        ));
  }
}
