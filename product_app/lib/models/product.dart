import 'dart:convert';

List<Product> productFromJson(String str) =>
    List<Product>.from(json.decode(str).map((x) => Product.fromJson(x)));

String productToJson(List<Product> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Product {
  Product({
    this.id,
    this.categoryId,
    this.productName,
    this.quantityPerUnit,
    this.unitPrice,
    this.unitsInStock,
  });

  int id;
  int categoryId;
  String productName;
  String quantityPerUnit;
  double unitPrice;
  int unitsInStock;

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        id: json["id"],
        categoryId: json["categoryId"],
        productName: json["productName"],
        quantityPerUnit: json["quantityPerUnit"],
        unitPrice: double.tryParse(json["unitPrice"].toString()),
        unitsInStock: json["unitsInStock"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "categoryId": categoryId,
        "productName": productName,
        "quantityPerUnit": quantityPerUnit,
        "unitPrice": unitPrice,
        "unitsInStock": unitsInStock,
      };
}
