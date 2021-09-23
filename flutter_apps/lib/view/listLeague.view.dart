import 'package:flutter/material.dart';
import 'package:flutter_apps/controller/allLeague.controller.dart';
import 'package:flutter_apps/controller/schedule.controler.dart';
import 'package:flutter_apps/view/schedule.view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

class ListLeague extends StatelessWidget {
  const ListLeague({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    AllLeague allLeague = Get.put(AllLeague());
    ScheduleController scheduleController = Get.put(ScheduleController());
    allLeague.getAllLeague();
    return Obx(() => allLeague.items.length == 0
        ? Container(
            color: Colors.grey,
            child: Center(
              child: Loading(
                indicator: BallBeatIndicator(),
              ),
            ))
        : GridView.builder(
            gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                maxCrossAxisExtent: 250,
                childAspectRatio: 2 / 3,
                crossAxisSpacing: 20,
                mainAxisSpacing: 20),
            itemCount: allLeague.items.length,
            itemBuilder: (BuildContext ctx, index) {
              return Container(
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
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
                child: InkWell(
                  child: Column(
                    children: [
                      Container(
                          height: 128,
                          width: 128,
                          child: ![null, ""]
                                  .contains(allLeague.items[index]["strBadge"])
                              ? Image.network(
                                  allLeague.items[index]["strBadge"])
                              : Image.network(
                                  "https://i.pinimg.com/564x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")),
                      Text(
                        allLeague.items[index]["strLeague"] ?? "No Name",
                        style: GoogleFonts.abrilFatface(
                            fontSize: 12, color: Colors.black87),
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Website: ',
                            style: GoogleFonts.abrilFatface(
                                fontSize: 10,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal),
                          ),
                          Expanded(
                            child: Text(
                              allLeague.items[index]["strWebsite"] ?? "No Data",
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.abrilFatface(
                                  fontSize: 10, color: Colors.black87),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        children: [
                          Text(
                            'Year: ',
                            style: GoogleFonts.abrilFatface(
                                fontSize: 10,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal),
                          ),
                          Text(
                            allLeague.items[index]["intFormedYear"] ??
                                "No Data",
                            overflow: TextOverflow.clip,
                            style: GoogleFonts.abrilFatface(
                                fontSize: 10,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 8,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Desc: ',
                            style: GoogleFonts.abrilFatface(
                                fontSize: 10,
                                color: Colors.black87,
                                fontWeight: FontWeight.normal),
                          ),
                          Expanded(
                              child: Text(
                            allLeague.items[index]["strDescriptionEN"] ??
                                "No Data",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 4,
                            softWrap: true,
                            textAlign: TextAlign.justify,
                          )),
                        ],
                      )
                    ],
                  ),
                  onTap: () {
                    scheduleController.liga.value =
                        allLeague.items.value[index]["strLeague"];
                    scheduleController.idLiga.value =
                        allLeague.items.value[index]["idLeague"];
                    Get.to(() => Schedule());
                  },
                ),
              );
            }));
  }
}
