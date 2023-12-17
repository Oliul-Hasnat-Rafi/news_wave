import 'package:get/get.dart';
import 'package:news_wave/model/Category_dataModel.dart';
import 'package:news_wave/news_server/news_server.dart';

class CategoryController extends GetxController {
  CategorydataModel? Categorydata;

  RxList<CategorydataModel> catarticleslist = <CategorydataModel>[].obs;

  getarticles(String Catname) async {
    Categorydata = await Newsserver().getcategorydata(Catname);
    catarticleslist.add(Categorydata!);
    refresh();
  }
}
