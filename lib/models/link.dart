class Links {
  Links({
    this.self,
    this.collection,
  });

  List<Collection>? self;
  List<Collection>? collection;

  factory Links.fromJson(Map<String, dynamic> json) => Links(
    self: json["self"]!=null ?
    List<Collection>.from(json["self"].map((x) => Collection.fromJson(x))) : null,
    collection: json["collection"]!=null ?
    List<Collection>.from(json["collection"].map((x) => Collection.fromJson(x))) : null,
  );

  Map<String, dynamic> toJson() => {
    "self": self!=null ?
    List<dynamic>.from(self!.map((x) => x.toJson())) : null,
    "collection": collection!=null ?
    List<dynamic>.from(collection!.map((x) => x.toJson())) : null,
  };
}


class Collection {
  Collection({
    this.href,
  });

  String? href;

  factory Collection.fromJson(Map<String, dynamic> json) => Collection(
    href: json["href"],
  );

  Map<String, dynamic> toJson() => {
    "href": href,
  };
}