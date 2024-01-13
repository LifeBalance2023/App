import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/components/date_selector_component.dart';
import 'package:frontend/components/form_textfield.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_bloc.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_event.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_state.dart';

import '../../components/custom_button.dart';

class TaskCreatorScreen extends StatelessWidget {
  const TaskCreatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskCreatorBloc = BlocProvider.of<TaskCreatorBloc>(context);

    final titleTextController = TextEditingController();
    final descriptionTextController = TextEditingController();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Task',
            style: TextStyle(
              fontFamily: 'JejuGothic',
            )),
        actions: <Widget>[
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              AppRouter.goToSettings(context);
            },
          ),
        ],
      ),
      body: Container(
        color: const Color(0xFF9A8C98),
        width: double.infinity,
        height: double.infinity,
        child: SingleChildScrollView(
          child: BlocConsumer<TaskCreatorBloc, TaskCreatorState>(
            listener: (context, state) {
              _blocListener(state, titleTextController, descriptionTextController, context);
            },
            builder: (context, state) {
              return _blocBuilder(state, titleTextController, taskCreatorBloc, descriptionTextController, context);
            },
          ),
        ),
      ),
      floatingActionButton: CustomButtonComponent(
        text: 'Add',
        width: 140,
        height: 48,
        onPressed: () {
          taskCreatorBloc.add(TaskCreatorSaveRequested());
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    );
  }

  void _blocListener(
    TaskCreatorState state,
    TextEditingController titleTextController,
    TextEditingController descriptionTextController,
    BuildContext context,
  ) {
    if (state is TaskModificationState) {
      titleTextController.text = state.title;
      descriptionTextController.text = state.description ?? '';
    }
    if (state is TaskCreationSavingSuccess) {
      AppRouter.goBack(context);
    } else if (state is TaskCreationSavingFailure) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Failed to save task: ${state.error.message}')),
      );
    }
  }

  Widget _blocBuilder(
    TaskCreatorState state,
    TextEditingController titleTextController,
    TaskCreatorBloc taskCreatorBloc,
    TextEditingController descriptionTextController,
    BuildContext context,
  ) {
    if (state is TaskCreationSavingInProgress) {
      return const CircularProgressIndicator();
    } else {
      return Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(bottom: 2.0),
              child: FormTextfieldComponent(
                controller: titleTextController,
                fieldName: 'Title',
                hintText: 'Enter your title',
                obscureText: false,
                horizontalPadding: 16.0,
                onChanged: (value) {
                  taskCreatorBloc.add(TaskCreatorTitleChanged(value));
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: FormTextfieldComponent(
                controller: descriptionTextController,
                fieldName: 'Description',
                hintText: 'Enter your description',
                obscureText: false,
                horizontalPadding: 16.0,
                onChanged: (value) {
                  taskCreatorBloc.add(TaskCreatorDescriptionChanged(value));
                },
              ),
            ),
            _buildAllPriorityChips(state: state, context: context),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 2.0),
              child: DateTimeSelectorComponent(
                  label: 'Select Date',
                  initialDateTime: state.date,
                  includeTime: false,
                  horizontalPadding: 16.0,
                  onDateTimeChanged: (date) {
                    taskCreatorBloc.add(TaskCreatorDateChanged(date));
                  }),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 2.0),
              child: DateTimeSelectorComponent(
                  label: 'Select Notification Time',
                  initialDateTime: state.notificationTime ?? DateTime.now(),
                  includeTime: true,
                  horizontalPadding: 16.0,
                  onDateTimeChanged: (date) {
                    taskCreatorBloc.add(TaskCreatorNotificationTimeChanged(date));
                  }),
            ),
          ],
        ),
      );
    }
  }

  // TODO: Refactor this into a separate widget
  Padding _buildAllPriorityChips({
    required TaskCreatorState state,
    required BuildContext context,
  }) =>
      Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 16.0,
        ),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          const Text(
            'Select Priority',
            style: TextStyle(
              fontFamily: 'JejuGothic',
              fontSize: 24.0,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center, // Center the chips
            children: state.priorityChips.map((priorityChips) => _buildPriorityChip(context, priorityChips)).toList(),
          ),
        ]),
      );

  Widget _buildPriorityChip(BuildContext context, PriorityChips priorityChips) => Padding(
    padding: const EdgeInsets.all(2.0),
    child: ChoiceChip(
      label: Text(
        priorityChips.label,
        style: const TextStyle(
          fontFamily: 'JejuGothic',
          fontSize: 16.0,
          color: Color(0xFF604E5E), // Adjust color to match the TextField cursor color
        ),
      ),
      selected: priorityChips.isSelected,
      onSelected: (bool selected) {
        BlocProvider.of<TaskCreatorBloc>(context).add(TaskCreatorPriorityChanged(priorityChips.priority));
      },
      selectedColor: priorityChips.color,
      backgroundColor: const Color(0xFFD9D9D9), // Similar to TextField fill color
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15),
        side: BorderSide(
          color: priorityChips.isSelected ? Color(0xFFA68DA4) : Color(0xFF91778F), // Adjust border color
        ),
      ),
    ),
  );
}
