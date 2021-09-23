import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AllLeague extends GetxController {
  var items = [].obs;

  getAllLeague() async {
    dio.Response response = await dio.Dio().get(
        "https://www.thesportsdb.com/api/v1/json/1/search_all_leagues.php?s=Soccer");
    items.assignAll(response.data['countrys']);
  }
}
