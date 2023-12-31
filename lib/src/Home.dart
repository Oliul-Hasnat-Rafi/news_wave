import 'package:flutter/material.dart';

import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:news_wave/controller/Searchcontroller.dart';
import 'package:news_wave/controller/slider_controller.dart';
import 'package:news_wave/src/ShowCategory.dart';
import 'package:news_wave/src/article_view.dart';
import 'package:shimmer/shimmer.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Slidercontroller Slider = Get.put(Slidercontroller());
  Searchcontroller search = Get.put(Searchcontroller());
  TextEditingController searchController = TextEditingController();

  List category = [
    'Business',
    'Entertainment',
    'General',
    'Health',
    'Science',
    'sport'
  ];

  @override
  void initState() {
    super.initState();
    Slider.getslider();
  }

  void _performSearch(String query) async {
    await search.GetSearch(query);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'NEWS',
              style: TextStyle(fontSize: 20, color: Colors.blue),
            ),
            SizedBox(
              width: 5,
            ),
            Text(
              'WAVE',
              style: TextStyle(fontSize: 20, color: Colors.black),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextFormField(
              controller: searchController,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.symmetric(horizontal: 20),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30.0),
                ),
                hintText: 'Search',
                suffixIcon: searchController.text.isEmpty
                    ? const Icon(Icons.search)
                    : GestureDetector(
                        onTap: () {
                          searchController.text = "";
                          _performSearch("");
                        },
                        child: Icon(Icons.clear)),
              ),
              onChanged: (value) {
                _performSearch(value);
              },
            ),
          ),
          Obx(
            () => Visibility(
              visible: search.isSearching.value,
              child: Expanded(
                child: Obx(
                  () => search.Searchlist.isEmpty
                      ? Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: Column(
                            children: [
                              ListTile(
                                leading: Container(
                                  height: 50,
                                  width: 50,
                                  color: Colors.white,
                                ),
                                title: Container(
                                  width: 100,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                                subtitle: Container(
                                  width: double.infinity,
                                  height: 8.0,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        )
                      : ListView.builder(
                          itemCount: search.Searchlist[0].articles!.length,
                          itemBuilder: (context, index) {
                            return ListTile(
                              leading: Image(
                                height: 50,
                                width: 50,
                                image: NetworkImage(search
                                    .Searchlist[0].articles![index].urlToImage
                                    .toString()),
                              ),
                              title: Text(search
                                  .Searchlist[0].articles![index].title
                                  .toString()),
                              subtitle: Text("Effected: " +
                                  search.Searchlist[0].articles![index]
                                      .description
                                      .toString()),
                            );
                          },
                        ),
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !search.isSearching.value,
              child: Flexible(
                flex: 3,
                child: Swiper(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 150,
                        width: 150,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          image: DecorationImage(
                            image: NetworkImage(
                              Slider.slider!.articles![index].urlToImage
                                  .toString(),
                            ),
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    );
                  },
                  itemCount: 6,
                  duration: 1000,
                  pagination:
                      SwiperPagination(builder: RectSwiperPaginationBuilder()),
                  autoplay: true,
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !search.isSearching.value,
              child: Flexible(
                child: Container(
                  height: 60,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: category.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: GestureDetector(
                          onTap: () {
                            Get.to(ShowCategory(categoryname: category[index]));
                          },
                          child: Container(
                            height: 50,
                            width: 150,
                            decoration: BoxDecoration(
                              color: Colors.grey.shade200,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Center(
                              child: Text(
                                category[index].toString(),
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !search.isSearching.value,
              child: Padding(
                padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      "Breaking News!",
                      style: TextStyle(
                          color: Colors.black,
                          fontWeight: FontWeight.bold,
                          fontSize: 18.0),
                    ),
                    GestureDetector(
                      onTap: () {
                        // Navigator.push(context, MaterialPageRoute(builder: (context)=> AllNews(news: "Breaking")));
                      },
                      child: Text(
                        "View All",
                        style: TextStyle(
                            decoration: TextDecoration.underline,
                            decorationColor: Colors.blue,
                            color: Colors.blue,
                            fontWeight: FontWeight.w500,
                            fontSize: 16.0),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          Obx(
            () => Visibility(
              visible: !search.isSearching.value,
              child: Flexible(
                flex: 6,
                child: Obx(
                  () => Slider.sliderlist.length != 0
                      ? ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: Slider.slider!.articles!.length,
                          itemBuilder: (_, index) {
                            return GestureDetector(
                              onTap: () {
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ArticleView(
                                      blogUrl: Slider
                                          .slider!.articles![index].url
                                          .toString(),
                                    ),
                                  ),
                                );
                              },
                              child: Container(
                                margin: EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                      borderRadius: BorderRadius.circular(10),
                                      child: Image.network(
                                        Slider.slider!.articles![index]
                                                .urlToImage
                                                ?.toString() ??
                                            'https://i.postimg.cc/RhWtHc98/download.png',
                                        width: 150,
                                        height: 150,
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: const EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              Slider.slider!.articles![index]
                                                  .title
                                                  .toString(),
                                              maxLines: 2,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                color: Colors.black,
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Text(
                                              Slider.slider!.articles![index]
                                                  .description
                                                  .toString(),
                                              maxLines: 3,
                                              softWrap: true,
                                              overflow: TextOverflow.ellipsis,
                                              style: TextStyle(
                                                fontSize: 18.0,
                                                fontWeight: FontWeight.normal,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                        )
                      : Shimmer.fromColors(
                          baseColor: Colors.grey.shade700,
                          highlightColor: Colors.grey.shade100,
                          enabled: true,
                          child: ListView.builder(
                            scrollDirection: Axis.vertical,
                            itemCount: 6,
                            itemBuilder: (_, index) {
                              return Container(
                                margin: EdgeInsets.all(20),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    ClipRRect(
                                        borderRadius: BorderRadius.circular(10),
                                        child: Container(
                                          height: 150,
                                          width: 150,
                                          color: Colors.white,
                                        )),
                                    SizedBox(
                                      width: 10.0,
                                    ),
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.all(8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Container(
                                              height: 8,
                                              width: 150,
                                              color: Colors.white,
                                            ),
                                            SizedBox(
                                              height: 10.0,
                                            ),
                                            Container(
                                              height: 8,
                                              width: 150,
                                              color: Colors.white,
                                            )
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              );
                            },
                          ),
                        ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
