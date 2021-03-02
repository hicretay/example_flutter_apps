import 'package:flutter/cupertino.dart';
import 'package:product_app/models/product.dart';
import 'package:product_app/widgets/product_list_row.dart';

class ProductListWidget extends StatefulWidget {
  List<Product> products = new List<Product>();

  ProductListWidget(List<Product> products) {
    this.products = products;
  }

  @override
  State<StatefulWidget> createState() {
    return ProductListWidgetState();
  }
}

class ProductListWidgetState extends State<ProductListWidget> {
  @override
  Widget build(BuildContext context) {
    return buildProductList(context);
  }

  Widget buildProductList(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 10.0,
        ),
        SizedBox(
          height: 650,
          child: GridView.count(
            crossAxisCount: 2,
            children: List.generate(widget.products.length, (index) {
              return ProductListRowWidget(widget.products[index]);
            }),
          ),
        ),
      ],
    );
  }
}