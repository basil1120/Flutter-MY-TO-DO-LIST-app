import 'package:flutter/material.dart';
import 'package:to_do_list_app/screens/ScreenTodo.dart';

void main() => runApp(TodoListApp());

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        dividerColor: Color(0xFFECEDF1),
        brightness: Brightness.light,
        backgroundColor: Colors.white,
        primaryColor: Colors.purple,
        accentColor: Colors.cyan[600],
        fontFamily: 'Montserrat',
        textTheme: TextTheme(
          headline5: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
          headline6: TextStyle(fontSize: 22.0, fontWeight: FontWeight.bold),
          subtitle2: TextStyle(fontSize: 16),
          bodyText2: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat'),
          headline4: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat', color: Colors.white),
          headline3: TextStyle(fontSize: 14.0, fontFamily: 'Montserrat', color: Colors.black54),
        ),
      ),
      debugShowCheckedModeBanner: false,
      title: 'My Todo List',
      home: ScreenTodo(),
      routes: {
        '/home': (context) => ScreenTodo(),
      },
    );
  }
}
