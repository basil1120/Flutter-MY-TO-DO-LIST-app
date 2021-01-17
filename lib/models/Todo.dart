class Todo {
  int id;
  String title;
  String remindtime;

  Todo({this.id, this.title, this.remindtime});

  Map<String, dynamic> toMap() {
    return {'id': id, 'title': title , 'remindtime': remindtime};
  }
}