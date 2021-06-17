import 'package:hive/hive.dart';

part 'todo.g.dart';

@HiveType(typeId: 0)
class Todo extends HiveObject {
  @HiveField(0)
  String name;

  @HiveField(1)
  String discription;

  @HiveField(2)
  bool done = false;
  @HiveField(3)
  bool status = false;
   @HiveField(4)
   String photo;
  Todo({this.name,this.discription,this.photo});
}
