import 'package:frontend/repository/user_repository.dart';
import 'package:provider/provider.dart';
import 'package:provider/single_child_widget.dart';

import '../task_repository.dart';

List<SingleChildWidget> createRepositoryProviders() => [
      Provider<TaskRepository>(
        create: (_) => TaskRepository(),
      ),
      Provider<UserRepository>(
        create: (_) => UserRepository(),
      ),
    ];
