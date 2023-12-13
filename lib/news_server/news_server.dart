import 'package:dio/dio.dart';
import 'package:news_wave/model/Category_dataModel.dart';
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
      //print('Slider data' + response.toString());
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
      print('Category data' + response.toString());
    } catch (e) {
      print(e);
    }
    return CategorydataModel.fromJson(response.data);
  }
}
