import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:task_app/modals/task.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  late double _deviceHeight, _deviceWidth;

  String? _newTask;
  Box? _box;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _deviceWidth = MediaQuery.of(context).size.width;
    _deviceHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Daily Task App",
          style: TextStyle(fontSize: 25),
        ),
        toolbarHeight: _deviceHeight * 0.15,
      ),
      body: _taskView(),
      floatingActionButton: _addButton(),
    );
  }

  Widget _taskList() {
    List tasks = _box!.values.toList();
    return ListView.builder(
      itemCount: tasks.length,
      itemBuilder: (BuildContext context, int _index) {
        var task = Task.fromMap(tasks[_index]);
        return ListTile(
          title: Text(
            task.content,
            style: TextStyle(
                decoration: task.done ? TextDecoration.lineThrough : null),
          ),
          subtitle: Text(
            task.timeStamp.toString(),
          ),
          trailing: Icon(
            task.done
                ? Icons.check_box_outlined
                : Icons.check_box_outline_blank,
            color: Theme.of(context).colorScheme.secondary,
          ),
          onTap: () {
            task.done = !task.done;
            _box!.put(_index, task.toMap());
            setState(() {});
          },
          onLongPress: () {
            _box!.delete(_index);
            setState(() {});
          },
        );
      },
    );
  }

  Widget _addButton() {
    return FloatingActionButton(
      onPressed: _displayTaskPopUp,
      child: const Icon(Icons.add),
    );
  }

  Widget _taskView() {
    return FutureBuilder(
        future: Hive.openBox('tasks'),
        builder: (BuildContext _context, AsyncSnapshot _snapshot) {
          if (_snapshot.hasData) {
            _box = _snapshot.data;
            return _taskList();
          } else {
            return const Center(child: CircularProgressIndicator());
          }
        });
  }

  void _displayTaskPopUp() {
    showDialog(
        context: context,
        builder: (BuildContext _context) {
          return AlertDialog(
            title: const Text(
              "Add New Task",
              style: TextStyle(fontSize: 15),
            ),
            content: TextField(
              onSubmitted: (_value) {
                if (_newTask != null) {
                  var taskAdd = Task(
                      content: _newTask!,
                      timeStamp: DateTime.now(),
                      done: false);
                  _box!.add(taskAdd.toMap());
                  setState(() {
                    _newTask = null;
                    Navigator.pop(context);
                  });
                }
              },
              onChanged: (_value) {
                setState(() {
                  _newTask = _value;
                });
              },
            ),
          );
        });
  }
}
