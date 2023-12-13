import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:news_wave/controller/category_controller.dart';

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
              color: Colors.black, fontSize: 26.0, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
