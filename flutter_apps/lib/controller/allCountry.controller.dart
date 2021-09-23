import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class AllCountry extends GetxController {
  var items = [].obs;
  var itemsFinal = [].obs;

  getAllCountry() async {
    dio.Response response = await dio.Dio()
        .get("https://www.thesportsdb.com/api/v1/json/1/all_countries.php");
    items.assignAll(response.data['countries']);
    itemsFinal.assignAll(response.data['countries']);
  }
}
