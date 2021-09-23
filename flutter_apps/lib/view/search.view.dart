import 'package:flutter/material.dart';
import 'package:flutter_apps/controller/search.controller.dart';
import 'package:get/get.dart';
import 'package:flutter_apps/view/listClubCountry.view.dart';

class Search extends StatelessWidget {
  const Search({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    SearchController searchController = Get.put(SearchController());
    searchController.resultSearch("");
    return Container(
      padding: EdgeInsets.all(8),
      child: Column(
        children: [
          TextField(
              decoration: new InputDecoration(hintText: 'Search'),
              onChanged: (String filter) {
                searchController.resultSearch(filter);
              }),
          SizedBox(
            height: 16,
          ),
          Expanded(
              child: Obx(() => ListView.builder(
                  itemCount: searchController.items.length,
                  itemBuilder: (context, index) {
                    return InkWell(
                      onTap: () {
                        showDialog<void>(
                            context: context,
                            builder: (BuildContext context) {
                              return SimpleDialog(
                                children: [
                                  CardTeam(searchController.items[index])
                                ],
                              );
                            });
                      },
                      child: Card(
                        elevation: 8,
                        child: ListTile(
                          leading: CircleAvatar(
                              backgroundImage: ![null, ""].contains(
                                      searchController.items[index]
                                          ["strTeamBadge"])
                                  ? NetworkImage(searchController.items[index]
                                      ["strTeamBadge"])
                                  : NetworkImage(
                                      "https://i.pinimg.com/564x/ae/8a/c2/ae8ac2fa217d23aadcc913989fcc34a2.jpg")),
                          title: Text(searchController.items[index]["strTeam"]),
                          subtitle:
                              Text(searchController.items[index]["strLeague"]),
                        ),
                      ),
                    );
                  }))),
        ],
      ),
    );
  }
}
