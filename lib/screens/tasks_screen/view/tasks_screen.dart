import 'package:flutter/material.dart';
import 'package:remindme/features/screen_layout/view/screen_layout.dart';
import '../../../core/classes/unique_controllers.dart';


class TasksScreen extends StatelessWidget {
  const TasksScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ScreenLayout(
      appBar: AppBar(
        title: Text('Mes tâches'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
          child: Column(
            children: [
              Card(
                child: ListTile(
                  title: Text('Tâche 1'),
                  subtitle: Text('Description de la tâche 1'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
              Card(
                child: ListTile(
                  title: Text('Tâche 2'),
                  subtitle: Text('Description de la tâche 2'),
                  trailing: Icon(Icons.more_vert),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
