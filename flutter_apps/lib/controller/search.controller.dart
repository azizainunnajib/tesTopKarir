import 'package:dio/dio.dart';
import 'package:get/get.dart';

class SearchController extends GetxController {
  var items = [].obs;

  resultSearch(String filter) async {
    var response = await Dio().get(
        "https://www.thesportsdb.com/api/v1/json/1/searchteams.php?t=$filter");
    items.assignAll(response.data['teams']);
  }
}
