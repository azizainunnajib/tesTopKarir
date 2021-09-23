import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AllClubContry extends GetxController {
  var items = [].obs;

  getAllClubByCountry(String country) async {
    dio.Response response = await dio.Dio().get(
        "https://www.thesportsdb.com/api/v1/json/1/search_all_teams.php?s=Soccer&c=$country");
    items.assignAll(response.data['teams']);
  }
}
