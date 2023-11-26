class Task {
  String content;
  DateTime timeStamp;
  bool done;

  Task({required this.content, required this.timeStamp, required this.done});

  factory Task.fromMap(Map task) {
    return Task(
        content: task["content"],
        timeStamp: task["timestamp"],
        done: task["done"]);
  }

  Map toMap() {
    return {"content": content, "timestamp": timeStamp, "done": done};
  }
}
