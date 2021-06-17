import 'package:hive/hive.dart';
import './todo.dart';

class Boxes {
  static Box<Todo> getTransactions() =>
      Hive.box<Todo>('todos');
}