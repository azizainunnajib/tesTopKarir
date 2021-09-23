import 'package:get/get.dart';
import 'package:dio/dio.dart' as dio;

class ScheduleController extends GetxController {
  var liga = ''.obs;
  var items = [].obs;
  var idLiga = ''.obs;
  var allSeason = ['2021-2022'].obs;
  var season = '2021-2022'.obs;
  getAllSchedule() async {
    dio.Response response = await dio.Dio().get(
        "https://www.thesportsdb.com/api/v1/json/1/eventsseason.php?id=${idLiga.value}&s=${season.value}");
    items.assignAll(response.data['events']);
  }

  getAllSeason() async {
    dio.Response response = await dio.Dio().get(
        "https://www.thesportsdb.com/api/v1/json/1/search_all_seasons.php?id=${idLiga.value}");
    List<dynamic> value = response.data['seasons'];
    allSeason.assignAll(value.map((e) => e['strSeason']));
  }
}
