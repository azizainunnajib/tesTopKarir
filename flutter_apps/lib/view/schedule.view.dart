import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_apps/controller/schedule.controler.dart';
import 'package:flutter_apps/view/bottomSheetSchedule.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';
import 'package:intl/intl.dart';
import 'package:intl/date_symbol_data_local.dart';

class Schedule extends StatelessWidget {
  const Schedule({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ScheduleController scheduleController = Get.find();
    scheduleController.getAllSchedule();
    final DateTime now = DateTime.now();
    initializeDateFormatting();
    final DateFormat formatter = DateFormat('HH:mm, dd MMMM yyyy', "in_ID");
    final String formatted = formatter.format(now);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Obx(() => Text('Schedule ${scheduleController.liga.value}')),
          ),
          body: Obx(
            () => scheduleController.items.length == 0
                ? Container(
                    color: Colors.grey,
                    child: Center(
                      child: Loading(
                        indicator: BallBeatIndicator(),
                      ),
                    ))
                : ListView.builder(
                    itemCount: scheduleController.items.length,
                    itemBuilder: (context, index) {
                      return Container(
                          height: 128,
                          padding: EdgeInsets.all(8),
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
                                offset:
                                    Offset(0, 3), // changes position of shadow
                              ),
                            ],
                          ),
                          child: Column(
                            children: [
                              Text(
                                  ![null, ''].contains(scheduleController
                                          .items[index]["strTimestamp"])
                                      ? formatter.format(DateTime.parse(
                                          scheduleController.items[index]
                                              ["strTimestamp"]))
                                      : "No Schedule Data",
                                  style: GoogleFonts.abrilFatface(
                                      fontSize: 14, color: Colors.black87)),
                              Row(
                                children: [
                                  Container(
                                    width: 140,
                                    child: Text(
                                        scheduleController.items[index]
                                            ["strHomeTeam"],
                                        style: GoogleFonts.abrilFatface(
                                            fontSize: 12,
                                            color: Colors.black87)),
                                  ),
                                  Expanded(
                                      child: ![null, ""].contains(
                                              scheduleController.items[index]
                                                  ["strThumb"])
                                          ? Image.network(scheduleController
                                              .items[index]["strThumb"])
                                          : Image.network(
                                              "https://i.pinimg.com/564x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")),
                                  Container(
                                    width: 140,
                                    child: Text(
                                        scheduleController.items[index]
                                            ["strAwayTeam"],
                                        textAlign: TextAlign.right,
                                        style: GoogleFonts.abrilFatface(
                                            fontSize: 12,
                                            color: Colors.black87)),
                                  ),
                                ],
                              ),
                            ],
                          ));
                    }),
          ),
          floatingActionButton: FloatingActionButton(
            child: Icon(Icons.search),
            onPressed: () => showModalBottomSheet(
                context: context,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                backgroundColor: Colors.white,
                builder: (BuildContext context) {
                  return BottomSheetSchedule();
                }),
          )),
    );
  }
}
