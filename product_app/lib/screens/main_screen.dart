import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:product_app/data/api/category_api.dart';
import 'package:product_app/data/api/product_api.dart';
import 'package:product_app/models/category.dart';
import 'package:product_app/models/product.dart';
import 'package:product_app/widgets/product_list_widget.dart';

class MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return MainScreenState();
  }
}

class MainScreenState extends State {
  List<Category> categories = List<Category>(); // apideki kategorilerin listesi
  List<Widget> categoryWidgets = List<Widget>(); //kategorileri widget gösterme
  List<Product> products = List<Product>();

  // Baslangıcta calısır getCategoriesFromApi cagırır
  @override
  void initState() {
    setState(() {
      getCategoriesFromApi();
      getProducts();
      super.initState();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: Colors.indigo[900],
          centerTitle: true,
          title: Text(
            "Alışveriş Kataloğu",
            style: TextStyle(color: Colors.white),
          )),
      body: Padding(
        padding: EdgeInsets.all(10.0),
        child: Column(
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal, //yatayda
              child: Row(
                children: categoryWidgets,
              ),
            ),
            ProductListWidget(products)
          ],
        ),
      ),
    );
  }

  //apiden liste olusturur listenin widgeta dönüsmesi için getCategoryWidgets a gider
  void getCategoriesFromApi() {
    CategoryApi.getCategories().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.categories =
            list.map((category) => Category.fromJson(category)).toList();
        getCategoryWidgets();
      });
    });
  }

  // listeyi widget a cevirir flatButton olusturulması için getCategoryWidget a gider
  List<Widget> getCategoryWidgets() {
    for (int i = 0; i < categories.length; i++) {
      categoryWidgets.add(getCategoryWidget(categories[i]));
    }
    return categoryWidgets;
  }

  //her bir eleman için flatButton olusturulması listeye eklenmesi
  Widget getCategoryWidget(Category category) {
    return FlatButton(
      child: Text(
        category.categoryName,
        style: TextStyle(color: Colors.blueGrey),
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
        side: BorderSide(color: Colors.lightGreen),
      ),
      onPressed: () {
        getProductsByCategoryId(category);
      },
    );
  }

  void getProductsByCategoryId(Category category) {
    ProductApi.getProductsByCategoryId(category.id).then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.products =
            list.map((product) => Product.fromJson(product)).toList();
      });
    });
  }

  void getProducts() {
    ProductApi.getProducts().then((response) {
      setState(() {
        Iterable list = json.decode(response.body);
        this.products =
            list.map((product) => Product.fromJson(product)).toList();
      });
    });
  }
}
