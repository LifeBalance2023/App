import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_bloc.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_state.dart';

class TaskCreatorScreen extends StatelessWidget {
  const TaskCreatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskCreatorBloc = BlocProvider.of<TaskCreatorBloc>(context);

    final titleTextController = TextEditingController();
    final descriptionTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
      ),
      body: BlocConsumer<TaskCreatorBloc, TaskCreatorState>(
        listener: (context, state) {
          if (state is TaskCreationSavingSuccess) {
            Navigator.pop(context);
          } else if (state is TaskCreationSavingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to save task: ${state.error}')),
            );
          }
        },
        builder: (context, state) => ,
      ),
    );
  }
}
