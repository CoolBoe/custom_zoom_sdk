class ImageLink {
  int? id;
  String? src;
  String? title;

  ImageLink({this.id, this.src, this.title});

  ImageLink.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    src = json['src'];
    title = json['title'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['id'] = this.id;
    data['src'] = this.src;
    data['title'] = this.title;
    return data;
  }
}