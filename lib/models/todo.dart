class ToDo {
  String id;
  String title;
  bool complete;

  ToDo({required this.id, required this.title, this.complete = false});

  Map<String, dynamic> toJson() {
    return {"title": title, "done": complete};
  }

  factory ToDo.fromJson(Map<String, dynamic> json) {
    return ToDo(id: json["id"], title: json["title"], complete: json["done"]);
  }
}
