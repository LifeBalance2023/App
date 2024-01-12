import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/domain/task_entity.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_bloc.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_event.dart';
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
          if (state is TaskModificationState) {
            titleTextController.text = state.title;
            descriptionTextController.text = state.description ?? '';
          }
          if (state is TaskCreationSavingSuccess) {
            Navigator.pop(context);
          } else if (state is TaskCreationSavingFailure) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Failed to save task: ${state.error.message}')),
            );
          }
        },
        builder: (context, state) {
          if (state is TaskCreationSavingInProgress) {
            return const CircularProgressIndicator();
          } else {
            return Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                children: <Widget>[
                  TextField(
                    controller: titleTextController,
                    decoration: const InputDecoration(labelText: 'Title'),
                    onChanged: (value) {
                      taskCreatorBloc.add(TaskCreatorTitleChanged(value));
                    },
                  ),
                  TextField(
                    controller: descriptionTextController,
                    decoration: const InputDecoration(labelText: 'Description'),
                    onChanged: (value) {
                      taskCreatorBloc.add(TaskCreatorDescriptionChanged(value));
                    },
                  ),
                  Row(
                    children: <Widget>[
                      _buildPriorityChip(context, 'Low', PriorityValue.low, state.priority, Colors.green),
                      _buildPriorityChip(context, 'Medium', PriorityValue.medium, state.priority, Colors.orange),
                      _buildPriorityChip(context, 'High', PriorityValue.high, state.priority, Colors.red),
                    ],
                  ),

                  // TODO: Add date selector
                  // TODO: Add notification time selector
                  ElevatedButton(
                    onPressed: () {
                      taskCreatorBloc.add(TaskCreatorSaveRequested());
                    },
                    child: const Text('Add'),
                  ),
                ],
              ),
            );
          }
        },
      ),
    );
  }


  Widget _buildPriorityChip(BuildContext context, String label, PriorityValue value, PriorityValue selectedPriority, Color color) {
    return ChoiceChip(
      label: Text(label),
      selected: value == selectedPriority,
      onSelected: (bool selected) {
        BlocProvider.of<TaskCreatorBloc>(context).add(TaskCreatorPriorityChanged(value));
      },
      selectedColor: color,
    );
  }
}
