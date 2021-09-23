import 'package:flutter/material.dart';
import 'package:flutter_apps/controller/allClubCountry.controller.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loading/indicator/ball_beat_indicator.dart';
import 'package:loading/loading.dart';

class ListClubCountry extends StatelessWidget {
  const ListClubCountry(this.country, {Key key}) : super(key: key);
  final String country;
  @override
  Widget build(BuildContext context) {
    AllClubContry allClubContry = Get.put(AllClubContry());
    allClubContry.getAllClubByCountry(country);
    return SafeArea(
      child: Scaffold(
          appBar: AppBar(
            title: Text('List Club in $country'),
          ),
          body: Obx(
            () => allClubContry.items.length == 0
                ? Container(
                    color: Colors.grey,
                    child: Center(
                      child: Loading(
                        indicator: BallBeatIndicator(),
                      ),
                    ))
                : Container(
                    // padding: EdgeInsets.symmetric(vertical: 8),
                    child: GridView.builder(
                        gridDelegate: SliverGridDelegateWithMaxCrossAxisExtent(
                            maxCrossAxisExtent: 200,
                            childAspectRatio: 2 / 3,
                            crossAxisSpacing: 20,
                            mainAxisSpacing: 20),
                        itemCount: allClubContry.items.length,
                        itemBuilder: (BuildContext ctx, index) {
                          return CardTeam(allClubContry.items[index]);
                        }),
                  ),
          )),
    );
  }
}

class CardTeam extends StatelessWidget {
  const CardTeam(this.data, {Key key}) : super(key: key);

  final dynamic data;
  @override
  Widget build(BuildContext context) {
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
      child: Column(
        children: [
          Container(
              height: 128,
              width: 128,
              child: ![null, ""].contains(data["strTeamBadge"])
                  ? Image.network(data["strTeamBadge"])
                  : Image.network(
                      "https://i.pinimg.com/564x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")),
          Text(
            data["strTeam"] ?? "No Name",
            style:
                GoogleFonts.abrilFatface(fontSize: 12, color: Colors.black87),
          ),
          SizedBox(
            height: 8,
          ),
          Row(
            children: [
              Text(
                'League: ',
                style: GoogleFonts.abrilFatface(
                    fontSize: 10,
                    color: Colors.black87,
                    fontWeight: FontWeight.normal),
              ),
              Expanded(
                child: Text(
                  data["strLeague"] ?? "No Data",
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
                data["intFormedYear"] ?? "No Data",
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
                data["strDescriptionEN"] ?? "No Data",
                overflow: TextOverflow.ellipsis,
                maxLines: 4,
                softWrap: true,
                textAlign: TextAlign.justify,
              )),
            ],
          )
        ],
      ),
    );
  }
}
