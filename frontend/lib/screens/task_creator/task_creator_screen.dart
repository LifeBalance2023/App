import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/components/custom_button.dart';
import 'package:frontend/components/custom_progress_indicator.dart';
import 'package:frontend/components/date_selector_component.dart';
import 'package:frontend/components/form_textfield.dart';
import 'package:frontend/router/router.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_bloc.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_event.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_state.dart';
import 'package:frontend/screens/task_creator/widgets/priority_chip_selector.dart';

class TaskCreatorScreen extends StatelessWidget {
  const TaskCreatorScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final taskCreatorBloc = BlocProvider.of<TaskCreatorBloc>(context);

    final titleTextController = TextEditingController();
    final descriptionTextController = TextEditingController();
    final formKey = GlobalKey<FormState>();

    return PopScope(
      onPopInvoked: (value) {
        taskCreatorBloc.add(TaskCreatorReset());
      },
      child: Scaffold(
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
                _blocListener(state, taskCreatorBloc, titleTextController, descriptionTextController, context);
              },
              builder: (context, state) {
                return _blocBuilder(state, titleTextController, taskCreatorBloc, descriptionTextController, formKey, context);
              },
            ),
          ),
        ),
        floatingActionButton: CustomButtonComponent(
          text: 'Add',
          width: 140,
          height: 48,
          onPressed: () {
            if (!formKey.currentState!.validate()) {
              return;
            }

            taskCreatorBloc.add(TaskCreatorSaveRequested());
          },
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      ),
    );
  }

  void _blocListener(
    TaskCreatorState state,
    TaskCreatorBloc taskCreatorBloc,
    TextEditingController titleTextController,
    TextEditingController descriptionTextController,
    BuildContext context,
  ) {
    if (state is TaskCreationSavingSuccess) {
      AppRouter.goBack(context);
      taskCreatorBloc.add(TaskCreatorReset());
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
    GlobalKey<FormState> formKey,
    BuildContext context,
  ) {
    if (state is TaskCreationSavingInProgress) {
      return const CustomProgressIndicator();
    } else {
      return Form(
        key: formKey,
        child: Padding(
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
                  textCapitalization: TextCapitalization.words,
                  onChanged: (value) {
                    taskCreatorBloc.add(TaskCreatorTitleChanged(value));
                  },
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return 'Field can\'t be empty';
                    }
                    return null;
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
                  textCapitalization: TextCapitalization.sentences,
                  onChanged: (value) {
                    taskCreatorBloc.add(TaskCreatorDescriptionChanged(value));
                  },
                ),
              ),
              PriorityChipSelector(
                priorityChips: state.priorityChips,
                onPrioritySelected: (selectedPriority) {
                  taskCreatorBloc.add(TaskCreatorPriorityChanged(selectedPriority));
                },
              ),
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
                    initialDateTime: state.notificationTime,
                    includeTime: true,
                    horizontalPadding: 16.0,
                    onDateTimeChanged: (date) {
                      taskCreatorBloc.add(TaskCreatorNotificationTimeChanged(date));
                    }),
              ),
            ],
          ),
        ),
      );
    }
  }
}
