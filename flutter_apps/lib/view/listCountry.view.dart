import 'package:flutter/material.dart';
import 'package:flutter_apps/controller/allCountry.controller.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

import 'listClubCountry.view.dart';

class ListCountry extends StatelessWidget {
  const ListCountry({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllCountry allCountryController = Get.put(AllCountry());
    allCountryController.getAllCountry();
    return Obx(
      () => allCountryController.items.length == 0
          ? Container(
              color: Colors.grey,
              child: Center(
                child: Loading(
                  indicator: BallBeatIndicator(),
                ),
              ))
          : Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 8),
                  child: TextField(
                    decoration: new InputDecoration(hintText: 'Search'),
                    onChanged: (val) {
                      var listRes = allCountryController.items.where((e) =>
                          e['name_en']
                              .toString()
                              .toLowerCase()
                              .contains(val.toLowerCase()));
                      allCountryController.itemsFinal.assignAll(listRes);
                    },
                  ),
                ),
                SizedBox(
                  height: 8,
                ),
                Expanded(
                  child: Container(
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 250,
                            childAspectRatio: 3 / 2,
                            crossAxisSpacing: 4,
                            mainAxisSpacing: 4),
                        itemCount: allCountryController.itemsFinal.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return Container(
                            margin: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(10),
                                  topRight: Radius.circular(10),
                                  bottomLeft: Radius.circular(10),
                                  bottomRight: Radius.circular(10)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.5),
                                  spreadRadius: 5,
                                  blurRadius: 7,
                                  offset: Offset(
                                      0, 3), // changes position of shadow
                                ),
                              ],
                            ),
                            child: InkWell(
                              child: Center(
                                  child: Text(
                                      allCountryController.itemsFinal[index]
                                          ["name_en"],
                                      textAlign: TextAlign.center,
                                      style: GoogleFonts.abrilFatface(
                                          fontSize: 20,
                                          color: Colors.black87))),
                              onTap: () => Get.to(() => ListClubCountry(
                                  allCountryController.itemsFinal[index]
                                      ["name_en"])),
                            ),
                          );
                        }),
                  ),
                ),
              ],
            ),
    );
  }
}
