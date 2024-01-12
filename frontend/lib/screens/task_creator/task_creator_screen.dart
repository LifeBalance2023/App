import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/router/router.dart';
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
    final dateTextController = TextEditingController();
    final notificationTimeTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task'),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              AppRouter.goToSettings(context);
            },
          ),
        ],
      ),
      body: BlocConsumer<TaskCreatorBloc, TaskCreatorState>(
        listener: (context, state) {
          if (state is TaskModificationState) {
            titleTextController.text = state.title;
            descriptionTextController.text = state.description ?? '';
            dateTextController.text = state.date.toString();
            notificationTimeTextController.text = state.notificationTime?.toString() ?? '';
          }
          if (state is TaskCreationSavingSuccess) {
            AppRouter.goBack(context);
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
                  Row(children: [
                    const Text("Priority: ", style: TextStyle(fontSize: 16)),
                    ...state.priorityChips.map((priorityChips) => _buildPriorityChip(context, priorityChips)).toList(),
                  ]),
                  _buildDateSelector(
                      context: context,
                      label: 'Select Date',
                      dateTextController: dateTextController,
                      selectedDate: state.date,
                      onDateChanged: (date) {
                        taskCreatorBloc.add(TaskCreatorDateChanged(date));
                      }),
                  _buildDateSelector(
                      context: context,
                      label: 'Select Notification Time',
                      dateTextController: notificationTimeTextController,
                      selectedDate: state.notificationTime ?? DateTime.now(),
                      onDateChanged: (date) {
                        taskCreatorBloc.add(TaskCreatorNotificationTimeChanged(date));
                      }),
                ],
              ),
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          taskCreatorBloc.add(TaskCreatorSaveRequested());
        },
        icon: const Icon(Icons.add),
        label: const Text('Add'),
      ),
    );
  }

  Widget _buildPriorityChip(BuildContext context, PriorityChips priorityChips) => ChoiceChip(
        label: Text(priorityChips.label),
        selected: priorityChips.isSelected,
        onSelected: (bool selected) {
          BlocProvider.of<TaskCreatorBloc>(context).add(TaskCreatorPriorityChanged(priorityChips.priority));
        },
        selectedColor: priorityChips.color,
      );

  Widget _buildDateSelector({
    required BuildContext context,
    required String label,
    required TextEditingController dateTextController,
    required DateTime selectedDate,
    required Function(DateTime) onDateChanged,
  }) =>
      TextFormField(
        controller: dateTextController,
        decoration: InputDecoration(
          labelText: label,
          suffixIcon: const Icon(Icons.calendar_today),
        ),
        readOnly: true,
        onTap: () async {
          DateTime? picked = await showDatePicker(
            context: context,
            initialDate: selectedDate,
            firstDate: DateTime(2000),
            lastDate: DateTime(2030),
          );
          if (picked != null && picked != selectedDate) {
            onDateChanged(picked);
          }
        },
      );
}
