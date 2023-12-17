import 'package:get/get.dart';
import 'package:news_wave/model/SearchModel.dart';
import 'package:news_wave/news_server/news_server.dart';

class Searchcontroller extends GetxController {
  SearchModel? Search;

  RxList<SearchModel> Searchlist = <SearchModel>[].obs;
  RxBool visibility = true.obs;

  RxBool isSearching = false.obs;

  GetSearch(String userquery) async {
    if (userquery.isNotEmpty) {
      final results = await Newsserver().getsearchdata(userquery.toString());
      Searchlist.add(results);
      visibility.value = false;
      isSearching.value = true;
      refresh();
    } else {
      userquery = '';
      visibility.value = true;
      isSearching.value = false;
      refresh();
    }
  }
}
