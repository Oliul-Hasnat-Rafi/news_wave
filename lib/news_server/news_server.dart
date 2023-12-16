import 'package:dio/dio.dart';
import 'package:news_wave/model/Category_dataModel.dart';
import 'package:news_wave/model/SearchModel.dart';
import 'package:news_wave/model/slider_model.dart';
import 'package:news_wave/news_server/Api_list.dart';

class Newsserver {
  Future<slidermodel> getslider() async {
    var response;
    var dio = Dio();
    String slider = ApiList.sliders.toString() + ApiList.apiKey.toString();
    try {
      response = await dio.get(slider);
      if (response.statusCode == 200) {
        slidermodel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return slidermodel.fromJson(response.data);
  }

  Future<CategorydataModel> getcategorydata(String category) async {
    var response;
    var dio = Dio();
    String slider =
        ApiList.categorydata + category.toString() + ApiList.apiKey.toString();
    try {
      response = await dio.get(slider);
      if (response.statusCode == 200) {
        slidermodel.fromJson(response.data);
      }
    } catch (e) {
      print(e);
    }
    return CategorydataModel.fromJson(response.data);
  }

  Future<SearchModel> getsearchdata(String query) async {
    var response;
    var dio = Dio();
    String searchresult = ApiList.Search +
        query.toString() +
        ApiList.sortby.toString() +
        ApiList.apiKey.toString();
    try {
      response = await dio.get(searchresult);
      if (response.statusCode == 200) {
        SearchModel.fromJson(response.data);
      }
      print('searchresult data' + response.toString());
    } catch (e) {
      print(e);
    }
    return SearchModel.fromJson(response.data);
  }
}
