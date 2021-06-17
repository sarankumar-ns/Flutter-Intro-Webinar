import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:todo_dis/todo.dart';

//import './todo_list.dart';
//import 'package:custom_switch/custom_switch.dart';

class NewTodoDialog extends StatefulWidget {
  @override
  _NewTodoDialogState createState() => _NewTodoDialogState();
}

class _NewTodoDialogState extends State<NewTodoDialog> {
  TextEditingController nameController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController photoController = TextEditingController();

  bool isSwitched = false;
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    descriptionController.dispose();
    photoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return (AlertDialog(
      key: _formKey,
      title: Text('Create To-Do List'),
      content: Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
        SizedBox(height: 10),
        TextFormField(
          decoration: InputDecoration(
            border: UnderlineInputBorder(),
            hintText: 'Title',
          ),
          controller: nameController,
          validator: (name) =>
              name != null && name.isEmpty ? 'Enter a name' : null,
        ),
        SizedBox(height: 10),
        Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
          SizedBox(height: 10),
          TextFormField(
            decoration: InputDecoration(
              border: UnderlineInputBorder(),
              hintText: 'Description',
            ),
            controller: descriptionController,
            validator: (description) =>
                description != null && description.isEmpty
                    ? 'Enter a description'
                    : null,
          ),
          SizedBox(height: 10),
          Column(mainAxisSize: MainAxisSize.min, children: <Widget>[
            SizedBox(height: 10),
            TextFormField(
              decoration: InputDecoration(
                border: UnderlineInputBorder(),
                hintText: 'Picture Url',
              ),
              controller: photoController,
              validator: (photo) =>
                  photo != null && photo.isEmpty ? 'Enter a photo link' : null,
            ),
            SizedBox(height: 10),
          ]),

          // Column(
          //   mainAxisSize: MainAxisSize.min,
          //   children: <Widget>[
          //     Text('urgent or not'),
          //     Container(
          //       margin: EdgeInsets.only(bottom: 3),
          //       child: Switch(
          //         value: isSwitched,
          //         // activeColor: Colors.blue,
          //         activeColor: Colors.green,
          //         activeTrackColor: Colors.greenAccent,
          //         inactiveThumbColor: Colors.red,
          //         inactiveTrackColor: Colors.redAccent,
          //
          //         onChanged: (value) {
          //           print("VALUE : $value");
          //           setState(() {
          //             isSwitched = value;
          //           });
          //         },
          //       ),
          //     ),
          //     SizedBox(
          //       height: 5.0,
          //     ),
          //     Text(
          //       'Value : $isSwitched',
          //       style: TextStyle(color: Colors.red, fontSize: 10.0),
          //     ),
          //   ],
          // ),
        ]),
      ]),
      actions: <Widget>[
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
        // ignore: deprecated_member_use
        FlatButton(
          child: Text('Add'),
          onPressed: () async {
            if (nameController.text.isNotEmpty ||
                descriptionController.text.isNotEmpty ||
                photoController.text.isNotEmpty) {
              var todo = Todo();

              todo.name = nameController.text;
              todo.discription = descriptionController.text;
              todo.status = isSwitched;
              todo.photo = photoController.text;
              Hive.box<Todo>('todos').add(todo);
            }

            Navigator.of(context).pop();
          },
        ),
      ],
    ));
  }
}
