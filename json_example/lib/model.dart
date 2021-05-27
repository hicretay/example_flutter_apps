// To parse this JSON data, do
//
//     final dataModel = dataModelFromJson(jsonString);

import 'dart:convert';

DataModel dataModelFromJson(String str) => DataModel.fromJson(json.decode(str));

String dataModelToJson(DataModel data) => json.encode(data.toJson());

class DataModel {
    DataModel({
        this.document,
    });

    List<Document> document;

    factory DataModel.fromJson(Map<String, dynamic> json) => DataModel(
        document: List<Document>.from(json["document"].map((x) => Document.fromJson(x))),
    );

    Map<String, dynamic> toJson() => {
        "document": List<dynamic>.from(document.map((x) => x.toJson())),
    };
}

class Document {
    Document({
        this.id,
        this.name,
    });

    int id;
    String name;

    factory Document.fromJson(Map<String, dynamic> json) => Document(
        id: json["id"],
        name: json["name"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "name": name,
    };
}