import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:frontend/screens/task_creator/bloc/task_creator_bloc.dart';
import 'package:frontend/services/tasks/tasks_service.dart';
import 'package:provider/single_child_widget.dart';

List<SingleChildWidget> createTaskCreatorProviders() => [
  BlocProvider<TaskCreatorBloc>(
    create: (context) => TaskCreatorBloc(
      context.read<TasksService>(),
    ),
  ),
];