import 'package:flutter/material.dart';
import './todo.dart';
//import './new_todo_dialog.dart';

class TodoList extends StatelessWidget {
  final List<Todo> todos;

  const TodoList(this.todos);

  @override
  Widget build(BuildContext context) {
    if (todos.isEmpty) {
      return Center(
        child: Text('Noting in To-Do...'),
      );
    } else {
      return ListView.builder(
        itemCount: todos.length,
        itemBuilder: (BuildContext context, int index) {
          var todo = todos[index];
          return _buildTodo(todo);
        },
      );
    }
  }

  Widget _buildTodo(Todo todo) {
    return Stack(
      children: <Widget>[
        Card(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.all(20.0),
            child: Row(children: <Widget>[
              Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5.0),
                      child: Image.network(
                        todo.photo,
                        fit: BoxFit.cover,
                        height: 48,
                        width: 48,
                      ),
                    ),
                  ]),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(
                    todo.name,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      decoration: todo.done ? TextDecoration.lineThrough : null,
                    ),
                  ),
                  Text(
                    todo.discription,
                    style: TextStyle(fontSize: 16, color: Colors.grey[800]),
                  ),
                ],
              ),
              Spacer(),
              IconButton(
                iconSize: 30,
                icon: Icon(todo.done ? Icons.clear : Icons.check),
                onPressed: () {
                  todo.done = !todo.done;
                  todo.save();
                },
              ),
              IconButton(
                iconSize: 30,
                icon: Icon(Icons.delete),
                onPressed: () {
                  todo.delete();
                },
              ),
            ]),
          ),
        ),
        Positioned(
          top: 16,
          right: 16,
          child: Container(
            height: 10,
            width: 10,
            // padding: EdgeInsets.all(),
            decoration: todo.status
                ? BoxDecoration(color: Colors.red, shape: BoxShape.circle)
                : BoxDecoration(color: Colors.green, shape: BoxShape.circle),
          ),
        ),
      ],
    );
  }
}
