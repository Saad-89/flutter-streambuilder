import 'dart:async';

import 'package:flutter/material.dart';
import 'package:stream_builder/tast_model.dart';

class HomePage extends StatefulWidget {
  HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  StreamController<List<Task>> _taskStreamController =
      StreamController<List<Task>>();

  List<Task> _task = [
    Task(id: 'task1', taskName: 'Homework Done', isDone: false),
    Task(id: 'task2', taskName: 'Play football', isDone: false),
    Task(id: 'task3', taskName: 'Go to gym', isDone: false),
  ];

  @override
  void initState() {
    _taskStreamController.add(_task);
    super.initState();
  }

  void _addTask(String taskName) {
    final newTask = Task(
      id: "task${_task.length}",
      taskName: taskName,
      isDone: false,
    );
    _task.add(newTask);
    _taskStreamController.add(_task);
  }

  @override
  void dispose() {
    _taskStreamController.close();
    super.dispose();
  }

  TextEditingController _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.deepPurpleAccent,
        centerTitle: true,
        title: Text('StreamBuilder', style: TextStyle(color: Colors.white)),
      ),
      body: Column(
        children: [
          StreamBuilder<List<Task>>(
            stream: _taskStreamController.stream,
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return Center(
                  child: CircularProgressIndicator(
                    color: Colors.deepPurpleAccent,
                  ),
                );
              } else if (snapshot.hasError) {
                return Center(child: Text('Error: ${snapshot.error}'));
              } else if (!snapshot.hasData) {
                return Center(child: Text('No data'));
              } else {
                final tasks = snapshot.data;
                return Expanded(
                  child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: tasks!.length,
                    itemBuilder: (context, index) {
                      final task = tasks[index];
                      return ListTile(
                        leading: Text('${task.taskName}'),
                        trailing:
                            task.isDone
                                ? Icon(Icons.check)
                                : Icon(Icons.check_box_outline_blank),
                      );
                    },
                  ),
                );
              }
            },
          ),
          Padding(
            padding: EdgeInsets.all(9),
            child: Column(
              children: [
                TextField(
                  controller: _textController,
                  decoration: InputDecoration(border: OutlineInputBorder()),
                ),
                SizedBox(height: 8),
                ElevatedButton(
                  onPressed: () {
                    if (_textController.text.isNotEmpty) {
                      _addTask(_textController.text.toString());
                      _textController.clear();
                    }
                  },
                  child: Text('Add'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
