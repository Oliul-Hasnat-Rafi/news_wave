import 'package:get/get.dart';
import 'package:news_wave/model/SearchModel.dart';
import 'package:news_wave/news_server/news_server.dart';

class Searchcontroller extends GetxController {
  SearchModel? Search;

  RxList<SearchModel> Searchlist = <SearchModel>[].obs;
  RxBool visibity = true.obs;
  RxBool Searchvisibity = false.obs;

  GetSearch(String userquery) async {
    if (userquery.isNotEmpty) {
      final results = await Newsserver().getsearchdata(userquery.toString());
      Searchlist.add(results);
      visibity = false.obs;
      Searchvisibity = true.obs;
      refresh();
    } else {
      userquery = '';
      Searchvisibity = false.obs;
      visibity = true.obs;
      refresh();
    }
  }
}
