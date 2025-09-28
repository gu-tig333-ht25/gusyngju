import 'package:uuid/uuid.dart';
import 'package:uuid/v4.dart';

class ToDo {
  String id;
  String title;
  bool complete;

  ToDo({String? id, required this.title, this.complete = false})
    : id = id ?? Uuid().v4();
}
