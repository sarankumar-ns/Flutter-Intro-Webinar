import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_dis/new_todo_dialog.dart';
import 'package:todo_dis/todo.dart';
import 'package:todo_dis/todo_list.dart';
import './boxes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(TodoAdapter());
  await Hive.openBox<Todo>('todos');
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'To-Do App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'OpenSans',
      ),
      home: Center(
        child: ConstrainedBox(
          constraints: BoxConstraints(maxWidth: 600),
          child: FutureBuilder(
            future: Future.wait([
              Hive.openBox('settings'),
              Hive.openBox<Todo>('todos'),
            ]),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.done) {
                if (snapshot.error != null) {
                  print(snapshot.error);
                  return Scaffold(
                    body: Center(
                      child: Text('Something went wrong :/'),
                    ),
                  );
                } else {
                  return TodoMainScreen();
                }
              } else {
                return Scaffold(
                  body: Center(
                    child: Text('Opening Notes...'),
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }
}

class TodoMainScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: ValueListenableBuilder(
            valueListenable: Hive.box('settings').listenable(),
            builder: _buildWithBox,
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          showDialog(
            context: context,
            builder: (context) {
              return NewTodoDialog();
            },
          );
        },
      ),
    );
  }

  Widget _buildWithBox(BuildContext context, Box settings, Widget child) {
    var reversed = settings.get('reversed', defaultValue: true) as bool;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'To-Do',
              style: TextStyle(fontSize: 40),
            ),
            const SizedBox(width: 20),
            IconButton(
              icon: Icon(
                reversed ? Icons.keyboard_arrow_up : Icons.keyboard_arrow_down,
                size: 32,
              ),
              onPressed: () {
                settings.put('reversed', !reversed);
              },
            ),
          ],
        ),
        const SizedBox(height: 10),
        Text( 'Save notes on the go.',
          textAlign: TextAlign.center,
        ),
        const SizedBox(height: 40),
        Expanded(
          child: ValueListenableBuilder<Box<Todo>>(
            valueListenable: Boxes.getTransactions().listenable(),
            builder: (context, box, _) {
              var todos = box.values.toList().cast<Todo>();
              if (reversed) {
                todos = todos.reversed.toList();
              }
              return TodoList(todos);
            },
          ),
        ),
      ],
    );
  }
}
