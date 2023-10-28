
class DummyModel {
  int? userId;
  int? id;
  String? title;
  String? body;

  DummyModel({this.userId, this.id, this.title, this.body});

  DummyModel.fromJson(Map<String, dynamic> json) {
    userId = json['userId'];
    id = json['id'];
    title = json['title'];
    body = json['body'];
  }

  static List<DummyModel> convertToList(List<dynamic> list) {
    if (list == null) return [];

    List<DummyModel> data = [];
    list.forEach((element) {
      data.add(DummyModel.fromJson(element));
    });

    return data;
  }
}