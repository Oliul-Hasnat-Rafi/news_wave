import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_wave/controller/category_controller.dart';
import 'package:news_wave/src/article_view.dart';
import 'package:shimmer/shimmer.dart';

class ShowCategory extends StatefulWidget {
  String categoryname;
  ShowCategory({super.key, required this.categoryname});

  @override
  State<ShowCategory> createState() => _ShowCategoryState();
}

class _ShowCategoryState extends State<ShowCategory> {
  CategoryController catarticles = Get.put(CategoryController());
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    catarticles.getarticles(widget.categoryname.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(
            widget.categoryname.toString(),
            style: TextStyle(
                color: Colors.black,
                fontSize: 20.0,
                fontWeight: FontWeight.bold),
          ),
          centerTitle: true,
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10.0),
          child: Expanded(
              child: Obx(() => catarticles.catarticleslist.isEmpty
                  ? ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: catarticles.Categorydata!.articles!.length,
                      itemBuilder: (context, index) {
                        return Shimmer.fromColors(
                            baseColor: Colors.grey.shade700,
                            highlightColor: Colors.grey.shade100,
                            enabled: true,
                            child: SingleChildScrollView(
                              physics: NeverScrollableScrollPhysics(),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisSize: MainAxisSize.max,
                                children: [
                                  Container(
                                    height: 150,
                                    width: 150,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 5.0,
                                  ),
                                  Container(
                                    height: 8,
                                    width: 150,
                                    color: Colors.white,
                                  ),
                                  Container(
                                    height: 8,
                                    width: 150,
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    height: 20.0,
                                  ),
                                ],
                              ),
                            ));
                      })
                  : ListView.builder(
                      shrinkWrap: true,
                      physics: ClampingScrollPhysics(),
                      itemCount: catarticles.Categorydata!.articles!.length,
                      itemBuilder: (context, index) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.pushReplacement(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => ArticleView(
                                        blogUrl: catarticles.catarticleslist[0]
                                            .articles![index].url
                                            .toString())));
                          },
                          child: Container(
                            child: Column(
                              children: [
                                ClipRRect(
                                    borderRadius: BorderRadius.circular(10),
                                    child: Image.network(
                                        catarticles.catarticleslist[0]
                                            .articles![index].urlToImage
                                            .toString(),
                                        width:
                                            MediaQuery.of(context).size.width,
                                        height: 200,
                                        fit: BoxFit.cover)),
                                SizedBox(
                                  height: 5.0,
                                ),
                                Text(
                                  catarticles
                                      .catarticleslist[0].articles![index].title
                                      .toString(),
                                  maxLines: 2,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 18.0,
                                      fontWeight: FontWeight.bold),
                                ),
                                Text(
                                  catarticles.catarticleslist[0]
                                      .articles![index].description
                                      .toString(),
                                  maxLines: 3,
                                ),
                                SizedBox(
                                  height: 20.0,
                                ),
                              ],
                            ),
                          ),
                        );
                      }))),
        ));
  }
}
