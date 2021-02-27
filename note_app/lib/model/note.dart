class Note {
  int id;
  String title;
  String description;

  Note({this.title, this.description});
  Note.withId({this.id, this.title, this.description});

  Map<String, dynamic> toMap() {
    var map = Map<String, dynamic>();
    map["title"] = title;
    map["description"] = description;
    if (id != null) {
      map["id"] = id;
    }
    return map;
  }

  Note.fromObject(dynamic o) {
    this.id = int.tryParse(o["id"].toString());
    this.title = o["title"];
    this.description = o["description"];
  }
}
