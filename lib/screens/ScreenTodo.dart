import 'package:flutter/material.dart';
import 'package:to_do_list_app/database/DatabaseHelper.dart';
import 'package:to_do_list_app/models/Todo.dart';
import 'package:intl/intl.dart';


class ScreenTodo extends StatefulWidget {
  //ScreenTodo({Key key, this.title}) : super(key: key);
  //final String title;

  @override
  _ScreenTodoState createState() => _ScreenTodoState();
}

class _ScreenTodoState extends State<ScreenTodo> {
  TextEditingController textController = new TextEditingController();

  List<Todo> taskList = new List();

  @override
  void initState() {
    super.initState();

    DatabaseHelper.instance.queryAllRows().then((value) {
      setState(() {
        value.forEach((element) {
          taskList.add(Todo(id: element['id'], title: element["title"], remindtime: element["remindtime"]));
        });
      });
    }).catchError((error) {
      print(error);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TO DO LIST"),
      ),
      body: Container(
        alignment: Alignment.topLeft,
        padding: EdgeInsets.all(16),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Expanded(
                  child: TextFormField(
                    decoration: InputDecoration(hintText: "Enter your task"),
                    controller: textController,
                  ),
                ),
                IconButton(
                  icon: Icon(Icons.add),
                  onPressed: _addToDb,
                )
              ],
            ),
            SizedBox(height: 20),
            Expanded(
              child: Container(
                child: taskList.isEmpty
                    ? Container()
                    : ListView.builder(itemBuilder: (ctx, index) {
                  if (index == taskList.length) return null;
                  return ListTile(
                    title: Text(taskList[index].title),
                    subtitle: Text(taskList[index].remindtime),
                    leading: Text(taskList[index].id.toString()),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => _deleteTask(taskList[index].id),
                    ),
                  );
                }),
              ),
            )
          ],
        ),
      ),
    );
  }

  void _deleteTask(int id) async {
    await DatabaseHelper.instance.delete(id);
    setState(() {
      taskList.removeWhere((element) => element.id == id);
    });
  }

  void _addToDb() async {
    String task = textController.text;
    DateFormat dateFormat = DateFormat("yyyy-MM-dd HH:mm");
    String remindTime = dateFormat.format(DateTime.now());

    var id = await DatabaseHelper.instance.insert(Todo(title: task, remindtime: remindTime));
    setState(() {
      textController.text = '';
      taskList.insert(0, Todo(id: id, title: task, remindtime: remindTime));
    });
  }
}