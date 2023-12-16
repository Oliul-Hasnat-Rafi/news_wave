import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:news_wave/controller/slider_controller.dart';
import 'package:news_wave/news_server/news_server.dart';
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
    // TODO: implement initState
    super.initState();
    Slider.getslider();
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
      body: Container(
          child: Column(children: [
        //...................................Search................................
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
                        setState(() {});
                      },
                      child: Icon(Icons.clear)),
            ),
            onChanged: (value) {
              setState(() {
                print(searchController);
              });
            },
          ),
        ),
// .......................Slider.............................
        Flexible(
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
                            fit: BoxFit.cover)),
                  ),
                );
              },
              itemCount: 6,
              duration: 1000,
              pagination:
                  const SwiperPagination(builder: SwiperPagination.rect),
              autoplay: true),
        ),
        // .......................Category item.............................
        Flexible(
          child: Container(
            height: 60,
            child: ListView.builder(
                shrinkWrap: true,
                physics: const ScrollPhysics(),
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
                            borderRadius: BorderRadius.circular(10)),
                        child: Center(
                          child: Text(
                            category[index].toString(),
                            style: TextStyle(fontSize: 20, color: Colors.black),
                          ),
                        ),
                      ),
                    ),
                  );
                }),
          ),
        ),
        Padding(
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

        // ........................Breaking News............................
        Flexible(
          flex: 6,
          child: Obx(() => Slider.sliderlist.length != 0
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
                                    blogUrl: Slider.slider!.articles![index].url
                                        .toString())));
                      },
                      child: Container(
                        margin: EdgeInsets.all(20),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: Image.network(
                                Slider.slider!.articles![index].urlToImage
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
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      Slider.slider!.articles![index].title
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
                                      Slider
                                          .slider!.articles![index].description
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
                  })
              : Shimmer.fromColors(
                  baseColor: Colors.grey.shade300,
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
                                  child: Image.asset(
                                    "images/building.jpg",
                                    width: MediaQuery.of(context).size.width,
                                    height: MediaQuery.of(context).size.height /
                                        1.6,
                                    fit: BoxFit.cover,
                                  )),
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
                                        '',
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
                                        '',
                                        maxLines: 3,
                                        softWrap: true,
                                        overflow: TextOverflow.ellipsis,
                                        style: TextStyle(
                                          fontSize: 18.0,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ],
                          ),
                        );
                      }))),
        )
      ])),
    );
  }
}
