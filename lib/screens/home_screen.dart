import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:todo_app/models/db_model.dart';
import 'package:todo_app/screens/edit_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Task> tasks = [];

  void _addOrEditTask({Task? task, int? index}) async {
    final result = await Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => AddEditTaskScreen(task: task),
      ),
    );

    if (result != null) {
      if (index == null) {
        setState(() {
          tasks.add(result);
        });
      } else {
        setState(() {
          tasks[index] = result;
        });
      }
    }
  }

  void _deleteTask(int index) {
    setState(() {
      tasks.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, index) {
            final task = tasks[index];
            return Container(
              margin: const EdgeInsets.symmetric(vertical: 4.0),
              padding: const EdgeInsets.all(8.0),
              decoration: BoxDecoration(
                color: Colors.lightBlueAccent.withOpacity(0.2),
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: ListTile(
                title: Text(task.title),
                subtitle: Text(task.description),
                trailing: Text(DateFormat('hh:mm a').format(task.time)),
                onTap: () => _addOrEditTask(task: task, index: index),
                onLongPress: () => _deleteTask(index),
              ),
            );
          },
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => _addOrEditTask(),
      ),
    );
  }
}
