import 'package:flutter/foundation.dart';

import '../modal.dart';

class TODOProvider extends ChangeNotifier {
  final List<TODOModal> _todolist = [];
  List<TODOModal> get allTODOList => _todolist;



  void addToDoList(TODOModal todoModal) {
    _todolist.add(todoModal);
    notifyListeners();
  }

  void todoStatusChange(TODOModal todoModal){
    final index = _todolist.indexOf(todoModal);
    _todolist[index].toggleCompleted();
    notifyListeners();
  }

void removeToDoList(TODOModal todoModal) {
 final index = _todolist.indexOf(todoModal);
 _todolist.removeAt(index);
 notifyListeners();
}
}