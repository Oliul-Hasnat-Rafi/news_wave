import 'package:flutter/material.dart';
import 'package:flutter_swiper_view/flutter_swiper_view.dart';
import 'package:get/get.dart';
import 'package:news_wave/controller/slider_controller.dart';
import 'package:news_wave/news_server/news_server.dart';
import 'package:news_wave/src/ShowCategory.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Slidercontroller Slider = Get.put(Slidercontroller());
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
        child: Column(
          children: [
            Expanded(
              child: Swiper(
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Container(
                        height: 200,
                        width: 200,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            image: DecorationImage(
                                image: NetworkImage(Slider
                                    .slider!.articles![index].urlToImage
                                    .toString()),
                                fit: BoxFit.fill)),
                      ),
                    );
                  },
                  itemCount: 6,
                  duration: 1000,
                  pagination:
                      const SwiperPagination(builder: SwiperPagination.rect),
                  autoplay: true),
            ),
            Flexible(
              child: Container(
                height: 60,
                child: ListView.builder(
                    // shrinkWrap: true,
                    // physics: const ScrollPhysics(),
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
                                style: TextStyle(
                                    fontSize: 20, color: Colors.black),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
