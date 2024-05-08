class TODOModal{
  String title;
  bool isCompleted;
  TODOModal({required this.title, required this.isCompleted});

  void toggleCompleted(){
    isCompleted= !isCompleted;
  }
}