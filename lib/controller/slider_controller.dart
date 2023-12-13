import 'package:get/get.dart';
import 'package:news_wave/model/slider_model.dart';
import 'package:news_wave/news_server/news_server.dart';

class Slidercontroller extends GetxController {
  slidermodel? slider;

  RxList<slidermodel> sliderlist = <slidermodel>[].obs;

  getslider() async {
    slider = await Newsserver().getslider();
    sliderlist.add(slider!);
    refresh();
  }
}
